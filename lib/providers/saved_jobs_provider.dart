import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobSaveProvider with ChangeNotifier {
  final List<String> _savedJobs = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // To get the current user

  JobSaveProvider() {
    _loadSavedJobs();
  }

  bool isJobSaved(String jobId) {
    return _savedJobs.contains(jobId);
  }


  void toggleSaveJob(String jobId) {
    if (isJobSaved(jobId)) {
      _savedJobs.remove(jobId);
    } else {
      _savedJobs.add(jobId);
    }
    _saveJobs();
    notifyListeners();
  }

  List<String> get savedJobs => _savedJobs;

  // Save the user's saved jobs list to Firestore
  void _saveJobs() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'savedJobs': _savedJobs,
    }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
  }


  void _loadSavedJobs() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists && doc['savedJobs'] != null) {
      List<String> savedJobs = List<String>.from(doc['savedJobs']);
      _savedJobs.addAll(savedJobs);
      notifyListeners();
    }
  }
}
