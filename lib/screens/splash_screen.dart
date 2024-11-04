import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pharma/providers/authentication_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  void _checkLoginState() async {
    await Future.delayed(const Duration(seconds: 2));

    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    if (authProvider.user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0D526A),
        child: Center(
          child: Image.asset(
            'assets/hand.png',
            width: 200,  
            height: 200, 
          ),
        ),
      ),
    );
  }
}
