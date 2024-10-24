import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobSaveProvider with ChangeNotifier {
  final List<String> _savedJobs = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // Load the user's saved jobs list from Firestore and remove deleted jobs
  void _loadSavedJobs() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (userDoc.exists && userDoc['savedJobs'] != null) {
      List<String> savedJobs = List<String>.from(userDoc['savedJobs']);

      // Now check if each saved job still exists in the jobs collection
      List<String> validJobs = [];
      for (String jobId in savedJobs) {
        DocumentSnapshot jobDoc = await _firestore.collection('jobs').doc(jobId).get();
        if (jobDoc.exists) {
          validJobs.add(jobId);
        } else {
          // Job doesn't exist anymore, so remove it from Firestore
          _savedJobs.remove(jobId);
        }
      }

      _savedJobs.clear();
      _savedJobs.addAll(validJobs);
      _saveJobs(); // Update Firestore with the valid saved jobs
      notifyListeners();
    }
  }
}
