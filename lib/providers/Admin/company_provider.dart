import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internir/models/company_model.dart';
import '../../models/job_model.dart';
import '../../services/fire_database.dart';

class CompanyProvider extends ChangeNotifier {
  List<JobModel> jobs = [];
  bool loading = false;

  Future<void> fetchJobs() async {
    try {
      loading = true;
      notifyListeners();
      var myJobs = await FirebaseFirestore.instance
          .collection('company')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('jobs')
          .get();

      for (var job in myJobs.docs) {
        jobs.add(JobModel.fromJson(
          await FireDatabase.getDocument('jobs', job.id),
        ));
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  

  Future<void> addJob({
    required String title,
    required String description,
    required String location,
    double? salary,
    String? category,
    String? employmentType,
    required bool enabled,
  }) async {
    try {
      loading = true;
      notifyListeners();
      DocumentReference<Map<String, dynamic>>? id = await FireDatabase.addData(
        collection: 'jobs',
        data: {
          'title': title,
          'description': description,
          'location': location,
          'salary': salary,
          'category': category,
          'job type': employmentType,
          'createdAt': Timestamp.fromDate(DateTime.now()),
          'number of applicants': 0,
          'enabled': enabled,
        },
      );

      var companyID = FirebaseAuth.instance.currentUser!.uid;
      // collection company doc:id collection jobs
      FirebaseFirestore.instance
          .collection('company')
          .doc(companyID)
          .collection('jobs')
          .doc(id!.id)
          .set({});

      // fetch company name
      var company = CompanyModel.fromJson(
          await FireDatabase.getDocument('company', companyID));
      await FireDatabase.updateData(
        'jobs',
        id.id,
        {'id': id.id, 'company': company.name},
      );

      fetchJobs();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> updateJob({
    required JobModel job,
  }) async {
    try {
      loading = true;
      notifyListeners();
      await FireDatabase.updateData(
        'jobs',
        job.id,
        job.toJson(),
      );
      fetchJobs();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteJob(String id) async {
    try {
      loading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('company')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('jobs')
          .doc(id)
          .delete();
      await FireDatabase.deleteData('jobs', id);
      fetchJobs();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
