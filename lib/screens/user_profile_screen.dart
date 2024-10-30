import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authentication_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('حسابي'),
        ),
        body: const Center(child: Text('لا يوجد مستخدم مسجل.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // أيقونة الشخص بدلاً من الصورة
            const Icon(
              Icons.person,
              size: 100, // حجم الأيقونة
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'معلومات المستخدم',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInfoCard('البريد الإلكتروني', user.email ?? "غير متوفر"),
            _buildInfoCard(
                'اسم المستخدم',
                authProvider.userName ??
                    "غير متوفر"), // افترض أنك تخزن اسم المستخدم في AuthenticationProvider
            _buildInfoCard(
                'رقم الهاتف',
                authProvider.userPhone ??
                    "غير متوفر"), // افترض أنك تخزن رقم الهاتف في AuthenticationProvider
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/edit_profile');
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('تعديل الملف الشخصي'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
