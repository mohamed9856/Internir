import 'package:flutter/material.dart';
import 'package:internir/models/job_model.dart';
import 'package:internir/services/fire_database.dart';

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
      var data = await FireDatabase.getData('jobs');
      for (var company in data) {
        for (var job in company['jobs']) {
          allJobs.add(JobModel.fromJson(job));
        }
      }

      jobs = allJobs;
    } catch (e) {
      print(e);
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
                  .contains(whatController.text.toLowerCase()) ||
              job.company
                  .toLowerCase()
                  .contains(whatController.text.toLowerCase())) &&
          job.location
              .toLowerCase()
              .contains(whereController.text.toLowerCase());
    }).toList();
    notifyListeners();
  }
}
