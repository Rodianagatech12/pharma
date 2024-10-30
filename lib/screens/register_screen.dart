import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authentication_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/without.png',
                  height: 300,
                ),
              ),
              const Text(
                "إنشاء حساب",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('ذكر')),
                  DropdownMenuItem(value: 'Female', child: Text('أنثى')),
                ],
                hint: const Text('اختر الجنس'),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'الجنس',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'تاريخ الميلاد',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    });
                  }
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (_selectedGender != null &&
                        _dateController.text.isNotEmpty) {
                      await Provider.of<AuthenticationProvider>(context,
                              listen: false)
                          .registerWithEmail(
                        _emailController.text,
                        _passwordController.text,
                        _dateController.text,
                        _selectedGender!,
                      );
                      Navigator.of(context).pushReplacementNamed('/account');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يرجى ملء جميع الحقول')),
                      );
                    }
                  } catch (e) {
                    String message;
                    if (e is FirebaseAuthException) {
                      switch (e.code) {
                        case 'email-already-in-use':
                          message = 'البريد الإلكتروني مستخدم بالفعل.';
                          break;
                        case 'weak-password':
                          message =
                              'كلمة المرور ضعيفة. يجب أن تكون 6 أحرف على الأقل.';
                          break;
                        case 'invalid-email':
                          message = 'البريد الإلكتروني غير صالح.';
                          break;
                        default:
                          message = 'فشل التسجيل: ${e.message}';
                      }
                    } else {
                      message = 'حدث خطأ غير متوقع.';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "إنشاء حساب",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                      '/home'); // توجيه المستخدم إلى الشاشة الرئيسية
                },
                child: const Text(
                  "هل لديك حساب؟ تسجيل الدخول",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
