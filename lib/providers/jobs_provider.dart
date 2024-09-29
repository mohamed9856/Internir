import 'package:flutter/material.dart';
import 'package:internir/models/job_model.dart';

class JobsProvider extends ChangeNotifier {
  TextEditingController whatController = TextEditingController();
  TextEditingController whereController = TextEditingController();

  var allJobs = <JobModel>[];
  var jobs = <JobModel>[];
  bool loading = false;

  Future<void> fetchJobs() async {
    try {
      loading = true;
      notifyListeners();
      allJobs = [
        JobModel(
          id: '1',
          enabled: true,
          title: 'flutter',
          description: 'We are looking for a software developer',
          location: 'Cairo, Egypt',
          category: 'Software Development',
          jobType: 'Remotly',
          deadline: DateTime.now().add(Duration(days: 7)),
          company: 'Google',
          createdAt: DateTime.now(),
          numberOfApplicants: 0,
        ),
        JobModel(
          id: '1=2',
          enabled: true,
          title: 'Software Developer',
          description: 'We are looking for a software developer',
          location: 'Cairo, Egypt',
          category: 'Software Development',
          jobType: 'Remotly',
          company: 'Google',
          createdAt: DateTime.now(),
          numberOfApplicants: 0,
        ),
        JobModel(
          id: '11',
          enabled: true,
          title: 'XO Developer',
          description: 'We are looking for a software developer',
          location: 'Uk',
          category: 'Software Development',
          jobType: 'Remotly',
          company: 'Google',
          createdAt: DateTime.now(),
          numberOfApplicants: 0,
        ),
        JobModel(
          id: '21',
          enabled: true,
          title: 'game Developer',
          description: 'We are looking for a software developer',
          location: 'Giza, Egypt',
          category: 'Software Development',
          jobType: 'Remotly',
          deadline: DateTime.now().add(Duration(days: 7)),
          company: 'Google',
          createdAt: DateTime.now(),
          numberOfApplicants: 0,
        ),
      ];
      jobs = allJobs;
    } catch (e) {
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void search() {
    jobs = allJobs.where((job) {
      return (job.title
                  .toLowerCase()
                  .contains(whatController.text.toLowerCase()) ||
              job.description
                  .toLowerCase()
                  .contains(whatController.text.toLowerCase())) &&
          job.location
              .toLowerCase()
              .contains(whereController.text.toLowerCase());
    }).toList();
    notifyListeners();
  }
}
