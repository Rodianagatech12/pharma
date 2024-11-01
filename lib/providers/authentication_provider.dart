import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  String? userName;
  String? userPhone;

  void updateUserName(String newName) {
    userName = newName;
    notifyListeners();
  }

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

      await _firestore.collection('users').doc(_user!.uid).set({
        'email': email,
        'name': name,
        'phone': phone,
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

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();

      if (userDoc.exists) {
        userName = userDoc['name'];
        userPhone = userDoc['phone'];
      }

      notifyListeners();
    } catch (e) {
      print("Login error: $e"); // تسجيل الخطأ
      throw e; // أو يمكنك استخدام rethrow
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
