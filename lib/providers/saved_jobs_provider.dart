import 'package:flutter/material.dart';

class JobSaveProvider with ChangeNotifier {
  final List<String> _savedJobs = [];

  bool isJobSaved(String jobId) {
    return _savedJobs.contains(jobId);
  }

  void toggleSaveJob(String jobId) {
    if (isJobSaved(jobId)) {
      _savedJobs.remove(jobId);
    } else {
      _savedJobs.add(jobId);
    }
    notifyListeners();
  }

  List<String> get savedJobs => _savedJobs;
}
