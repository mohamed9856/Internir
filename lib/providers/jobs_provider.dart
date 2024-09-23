import 'package:flutter/material.dart';
import 'package:internir/constants/end_points.dart';
import 'package:internir/models/adzuna_model.dart';
import 'package:internir/services/api_client.dart';
import 'package:internir/utils/utils.dart';

class JobsProvider extends ChangeNotifier {
  List<Results> jobs = [];
  List<Category> categories = [];
  int page = 1;
  bool hasMore = true;
  bool loading = false;

  TextEditingController whatController = TextEditingController();
  TextEditingController whereController = TextEditingController();

  Future<void> fetchJobs() async {
    try {
      hasMore = true;
      loading = true;
      notifyListeners();
      var res = await APIClient.get(
          "${searchJob.replaceAll('{country}', 'us').replaceAll('{page}', page.toString())}?app_id=${APIClient.appID}&app_key=${APIClient.appKEY}&what=${whatController.text}&where=${whereController.text}&results_per_page=20");
      jobs = List<Results>.from(res['results'].map((x) => Results.fromJson(x)));
      for (var job in jobs) {
        String fullDescription = await getFullDescription(job.id);
        job.description = fullDescription;
      }
      loading = false;
      if(jobs.length < 20) hasMore = false;
      notifyListeners();
    } catch (e) {
      debugPrint("${e}fetchJobs");
      hasMore = false;
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    try {
      loading = true;
      notifyListeners();
      var res = await APIClient.get(
          "${categoriesJob.replaceAll('{country}', 'us')}?app_id=${APIClient.appID}&app_key=${APIClient.appKEY}");
      categories =
          List<Category>.from(res['results'].map((x) => Category.fromJson(x)));
      notifyListeners();
    } catch (e) {
      debugPrint("${e}fetchCategories");
      loading = false;
      notifyListeners();
    }
  }
}
