import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internir/components/custom_button.dart';
import 'package:internir/components/custom_text_form_field.dart';
import 'package:internir/components/job_card.dart';
import 'package:internir/models/job_model.dart';
import 'package:internir/providers/jobs_provider.dart';
import 'package:internir/utils/app_assets.dart';
import 'package:internir/utils/app_color.dart';
import 'package:internir/utils/size_config.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final jobsProvider = context.watch<JobsProvider>();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Filter jobs',
                      style: TextStyle(
                        color: AppColor.mainBlue,
                        fontFamily: 'Greta Arabic',
                        fontSize: 20 * SizeConfig.textRatio,
                      ),
                    ),
                  ),
                  content: SizedBox(
                    width: SizeConfig.screenWidth * .8,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Job, Company, Title",
                            style: TextStyle(
                              fontFamily: 'Greta Arabic',
                              fontSize: 16 * SizeConfig.textRatio,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8 * SizeConfig.verticalBlock,
                          ),
                          customTextFormField(
                            controller: jobsProvider.whatController,
                          ),
                          SizedBox(
                            height: 20 * SizeConfig.verticalBlock,
                          ),
                          Text(
                            "Location",
                            style: TextStyle(
                              fontFamily: 'Greta Arabic',
                              fontSize: 16 * SizeConfig.textRatio,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8 * SizeConfig.verticalBlock,
                          ),
                          customTextFormField(
                            controller: jobsProvider.whereController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    CustomButton(
                      text: 'Filter',
                      onPressed: () {},
                      backgroundColor: AppColor.indigo,
                      textColor: Colors.white,
                      width: double.infinity,
                      height: 40 * SizeConfig.verticalBlock,
                    )
                  ],
                ),
              );
            },
          ),
          SizedBox(
            width: 16 * SizeConfig.horizontalBlock,
          )
        ],
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
              Image.asset(
                AppAssets.homeImage,
                width: 300 *
                    max(SizeConfig.horizontalBlock, SizeConfig.verticalBlock),
                height: 100 *
                    max(SizeConfig.horizontalBlock, SizeConfig.verticalBlock),
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 20 * SizeConfig.verticalBlock,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontFamily: 'Greta Arabic',
                        fontSize: 20 * SizeConfig.textRatio,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all",
                      style: TextStyle(
                          fontFamily: 'Greta Arabic',
                          fontSize: 16 * SizeConfig.textRatio,
                          color: AppColor.lightBlue2),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8 * SizeConfig.verticalBlock,
              ),

              // TODO: categories
              // SizedBox(
              //   height: 40 * SizeConfig.verticalBlock,
              //   child: ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: jobsProvider.categories.length,
              //     itemBuilder: (context, index) {
              //       final category = jobsProvider.categories[index];
              //       return categoryCard(category.label);
              //     },
              //     separatorBuilder: (context, index) {
              //       return SizedBox(
              //         width: 16 * SizeConfig.horizontalBlock,
              //       );
              //     },
              //   ),
              // ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final job = JobModel(
                    id: '1',
                    enabled: true,
                    title: 'Software Developer',
                    description: 'We are looking for a software developer',
                    location: 'Cairo, Egypt',
                    salary: 5000,
                    category: 'Software Development',
                    jobType: 'Remotly',
                    deadline: DateTime.now().add(Duration(days: 7)),
                    company: 'Google',
                    createdAt: DateTime.now(),
                    numberOfApplicants: 0,
                  );
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16 * SizeConfig.verticalBlock,
                      ),
                      jobCard(job, isApplied: true),
                      SizedBox(
                        height: 16 * SizeConfig.verticalBlock,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryCard(String category) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12 * SizeConfig.horizontalBlock,
          vertical: 8 * SizeConfig.verticalBlock,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.mainBlue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          category,
          style: TextStyle(
            fontFamily: 'Greta Arabic',
            fontSize: 16 * SizeConfig.textRatio,
            color: AppColor.mainBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
