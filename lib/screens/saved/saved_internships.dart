import 'package:flutter/material.dart';
import 'package:internir/components/job_card.dart';
import 'package:internir/providers/jobs_provider.dart';
import 'package:internir/utils/app_color.dart';
import 'package:internir/utils/size_config.dart';
import 'package:provider/provider.dart';

class SavedInternships extends StatefulWidget {
  const SavedInternships({super.key});

  @override
  State<SavedInternships> createState() => _SavedInternshipsState();
}

class _SavedInternshipsState extends State<SavedInternships> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _fetchSavedInternships();
    });
  }

  Future<void> _fetchSavedInternships() async {
    try {} catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobsProvider = context.watch<JobsProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Saved Internships',
          style: TextStyle(
            color: AppColor.mainBlue,
            fontSize: 30 * SizeConfig.textRatio,
            fontWeight: FontWeight.bold,
            fontFamily: 'NotoSans',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColor.mainBlue),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * SizeConfig.horizontalBlock,
            vertical: 20 * SizeConfig.verticalBlock,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*
              jobsProvider.loading
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              )
                  : jobsProvider.jobs.isNotEmpty
                  ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobsProvider.jobs.length,
                itemBuilder: (context, index) {
                  final job = jobsProvider.jobs[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16 * SizeConfig.verticalBlock,
                      ),
                      jobCard(job),
                      SizedBox(
                        height: 16 * SizeConfig.verticalBlock,
                      ),
                    ],
                  );
                },
              )
                  : Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'No saved internships found',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 16 * SizeConfig.textRatio,
                    ),
                  ),
                ),
              ),
            */
            ],
          ),
        ),
      ),
    );
  }
}
