import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  String? userName; // إضافة خاصية اسم المستخدم
  String? userPhone; // إضافة خاصية رقم الهاتف

  User? get user => _user;

  Future<void> registerWithEmail(
      String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      // حفظ المعلومات الإضافية في Firestore
      await _firestore.collection('users').doc(_user!.uid).set({
        'email': email,
        'name': name, // حفظ اسم المستخدم
        'phone': phone, // حفظ رقم الهاتف
      });

      userName = name;
      userPhone = phone;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      // جلب بيانات المستخدم من Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();

      if (userDoc.exists) {
        userName = userDoc['name']; // جلب اسم المستخدم
        userPhone = userDoc['phone']; // جلب رقم الهاتف
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    userName = null;
    userPhone = null;
    notifyListeners();
  }
}