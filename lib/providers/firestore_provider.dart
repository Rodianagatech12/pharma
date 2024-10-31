import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _pharmacies = [];
  List<Map<String, dynamic>> get pharmacies => _pharmacies;

  Future<void> fetchPharmacies() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('pharmacies').get();
      _pharmacies = snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching pharmacies: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchSections(String pharmacyId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('pharmacies')
          .doc(pharmacyId)
          .collection('sections')
          .get();
      return snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      print("Error fetching sections: $e");
      return [];
    }
  }
}
