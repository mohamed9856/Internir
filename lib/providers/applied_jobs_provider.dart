import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppliedJobsProvider with ChangeNotifier {
  final List<String> _appliedJobs = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userId;

  AppliedJobsProvider(this._userId) {
    _loadAppliedJobs();
  }

  bool isJobApplied(String jobId) {
    return _appliedJobs.contains(jobId);
  }

  void applyToJob(String jobId) {
    if (!isJobApplied(jobId)) {
      _appliedJobs.add(jobId);
      _saveAppliedJobs();
      notifyListeners();
    }
  }

  List<String> get appliedJobs => _appliedJobs;

  Future<void> _saveAppliedJobs() async {
    await _firestore.collection('users').doc(_userId).set({
      'appliedJobs': _appliedJobs,
    }, SetOptions(merge: true));
  }

  Future<void> _loadAppliedJobs() async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(_userId).get();
    if (doc.exists) {
      List<String> appliedJobs = List<String>.from(doc['appliedJobs'] ?? []);
      _appliedJobs.addAll(appliedJobs);
      notifyListeners();
    }
  }
}
