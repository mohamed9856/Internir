import 'package:flutter/material.dart';
import 'package:internir/components/job_card.dart';
import 'package:internir/constants/constants.dart';
import 'package:internir/providers/jobs_provider.dart';
import 'package:provider/provider.dart'; // Ensure you are using the provider package

class OneCategory extends StatefulWidget {
  final String categoryName; // Category name passed from the previous screen

  const OneCategory({super.key, required this.categoryName});

  @override
  State<OneCategory> createState() => _OneCategoryState();
}

class _OneCategoryState extends State<OneCategory> {
  @override
  void initState() {
    super.initState();

    _fetchJobsForCategory(); // Fetch jobs for the selected category
  }

  Future<void> _fetchJobsForCategory() async {
    // Fetch jobs for the selected category
    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
    // jobsProvider.category = widget.categoryName; // Set the category name
    await jobsProvider.fetchData(); // Fetch jobs based on the category
  }

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobsProvider>(context);

    if (jobProvider.jobsByCategory.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName, // Display the selected category
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
          icon: const Icon(Icons.keyboard_backspace_sharp),
          iconSize: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<JobsProvider>(
          builder: (context, jobsProvider, child) {
            if (jobsProvider.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (jobsProvider.jobs.isEmpty) {
              return const Center(
                  child: Text('No jobs found in this category.'));
            }

            return ListView.builder(
              itemCount: jobsProvider.jobs.length, // Number of jobs
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    jobsProvider.category = jobCategories[index];
                  },
                  child: Text(jobCategories[index]),
                ); // Display the job card
              },
            );
          },
        ),
      ),
    );
  }
}
