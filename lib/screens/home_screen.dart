import 'package:flutter/material.dart';
import 'package:pharma/providers/authentication_provider.dart';
import 'package:pharma/providers/dark_mode_provider.dart';
import 'package:pharma/providers/localization_provider.dart';
import 'package:pharma/screens/reminder_screen.dart';
import 'package:pharma/screens/shopping_cart_screen.dart';
import 'package:pharma/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'pharmacy_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final darkModeProvider = Provider.of<DarkModeProvider>(context);
    final isArabic =
        Provider.of<LocalizationProvider>(context).locale.languageCode == 'ar';

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: darkModeProvider.isDarkMode
            ? Colors.grey[850]
            : const Color(0xFF0D526A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/hand.png',
            fit: BoxFit.contain,
            height: 150,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: darkModeProvider.isDarkMode
                    ? Colors.grey[850]
                    : const Color(0xFF0D526A),
              ),
              child: Container(
                alignment: Alignment.bottomRight,
                child: const Text(
                  'دوائي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: Text(
                'الإعدادات',
                textAlign: TextAlign.right,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.black),
              title: const Text('اللغة'),
              onTap: () {
                Provider.of<LocalizationProvider>(context, listen: false)
                    .changeLanguage("ar");
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6, color: Colors.black),
              title: const Text('الوضع الليلي'),
              trailing: Switch(
                value: darkModeProvider.isDarkMode,
                onChanged: (value) {
                  darkModeProvider.toggleDarkMode();
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text('تسجيل الخروج'),
              onTap: () async {
                await authProvider.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 120,
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: PageView(
                    children: [
                      _buildAdCard(
                        'احصل على 25%',
                        'على طلبك الاول',
                        const Color(0xFFFF9800),
                        Icons.local_offer,
                        isArabic,
                      ),
                      _buildAdCard(
                        'جديد',
                        'تعرف على شريكنا الأحدث',
                        const Color(0x666D9918),
                        Icons.local_hospital,
                        isArabic,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'في التخفيض',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildProductCard('Pandol Joint', '32 LYB', '15%',
                          '45 LYB', 'assets/pill/pandol.png', isArabic),
                      _buildProductCard('Strepsils Honey', '11 LYB', '5%',
                          '20 LYB', 'assets/pill/stre.png', isArabic),
                      _buildProductCard('Bioderma', '75 LYB', '15%', '90 LYB',
                          'assets/pill/bio.png', isArabic),
                      _buildProductCard('Bioderma', '60 LYB', '15%', '80 LYB',
                          'assets/pill/sun.png', isArabic),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            ' ! تذكر دوائك',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildReminderCard(
                    'Omega3', '35 Minutes left', 'After Dinner', isArabic),
                _buildReminderCard(
                    'B-Complex', '35 Minutes left', 'After Dinner', isArabic),
              ],
            ),
          ),
          const PharmacyScreen(),
          const ReminderScreen(),
          const UserProfileScreen(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: 'الصيداليات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'تذكير',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 27, 150, 190),
        unselectedItemColor: const Color(0xFF0D526A),
        backgroundColor: darkModeProvider.isDarkMode
            ? Colors.grey[850]
            : const Color(0xFF0D526A),
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _buildProductCard(String name, String price, String discount,
    String originalPrice, String imagePath, bool isArabic) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCAE8E1).withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 200,
        width: 150,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                  Text(price, style: const TextStyle(fontSize: 16)),
                  Text(discount, style: const TextStyle(color: Colors.red)),
                  Text(
                    originalPrice,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildReminderCard(
    String medicine, String timeLeft, String afterMeal, bool isArabic) {
  return Card(
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: ListTile(
      title: Text(medicine,
          textAlign: isArabic ? TextAlign.right : TextAlign.left),
      subtitle: Text(timeLeft,
          textAlign: isArabic ? TextAlign.right : TextAlign.left),
      trailing: Text(afterMeal, textAlign: TextAlign.right),
    ),
  );
}

Widget _buildAdCard(
    String title, String subtitle, Color color, IconData icon, bool isArabic) {
  return Card(
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsets.all(10),
    child: ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
    ),
  );
}
