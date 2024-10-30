import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharma/firebase_options.dart';
import 'package:pharma/providers/authentication_provider.dart';
import 'package:pharma/providers/cart_provider.dart';
import 'package:pharma/providers/dark_mode_provider.dart';
import 'package:pharma/providers/firestore_provider.dart';
import 'package:pharma/providers/localization_provider.dart';
import 'package:pharma/screens/home_screen.dart';
import 'package:pharma/screens/login_screen.dart';
import 'package:pharma/screens/register_screen.dart';
import 'package:pharma/screens/settings_screen.dart';
import 'package:pharma/screens/shopping_cart_screen.dart';
import 'package:pharma/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(create: (_) => FirestoreProvider()),
        ChangeNotifierProvider(
          create: (_) => LocalizationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DarkModeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<DarkModeProvider>(
        builder: (context, darkModeProvider, child) {
          return MaterialApp(
            title: 'My App',
            theme: darkModeProvider.isDarkMode
                ? ThemeData.dark()
                : ThemeData.light(),
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/home': (context) => const HomeScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/cart': (context) => const ShoppingCartScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
