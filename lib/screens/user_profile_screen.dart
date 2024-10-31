import 'package:flutter/material.dart';
import 'package:pharma/screens/account_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/authentication_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return _buildNoUserScreen();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildHeader(authProvider), // الهيدر في أعلى الصفحة
            const SizedBox(height: 150),
            Center(
              // وضع الكروت في منتصف الصفحة
              child: Column(
                mainAxisSize: MainAxisSize.min, // جعل العمود بأقل ارتفاع ممكن
                children: [
                  _buildAccountDetailsCard(context),
                  const SizedBox(height: 20),
                  _buildLogoutCard(context, authProvider),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoUserScreen() {
    return const Scaffold(
      body: Center(child: Text('لا يوجد مستخدم مسجل.')),
    );
  }

  Widget _buildHeader(AuthenticationProvider authProvider) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(
            authProvider.userName ?? "غير متوفر",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تفاصيل الحساب',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.right,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AccountDetailsScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogoutCard(
      BuildContext context, AuthenticationProvider authProvider) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تسجيل الخروج',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.right,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            await authProvider.logout(); // استدعاء دالة تسجيل الخروج
          },
        ),
      ),
    );
  }
}
