import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internir/components/category_card.dart';
import 'package:internir/screens/category/categories.dart';
import 'package:internir/components/custom_button.dart';
import 'package:internir/components/job_card.dart';
import 'package:internir/constants/constants.dart';
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
    final user = FirebaseAuth.instance.currentUser;

    Future<bool> getAppliedState(int index) async {
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          List<dynamic> appliedJobs = userSnapshot.get('appliedJobs');
          return appliedJobs.contains(jobsProvider.jobs[index].id);
        }
      }
      return false;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.background,
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
                          fontFamily: 'NotoSans',
                          fontSize: 20 * SizeConfig.textRatio,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Categories.routeName);
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 16 * SizeConfig.textRatio,
                          color: AppColor.lightBlue2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8 * SizeConfig.verticalBlock,
                ),
                SizedBox(
                  height: 50 * SizeConfig.verticalBlock,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return categoryCard(
                          category: listCategories[index], context: context);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16 * SizeConfig.horizontalBlock,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16 * SizeConfig.verticalBlock,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: "Previous",
                      backgroundColor: AppColor.mainGreen,
                      isDisable: jobsProvider.page == 0,
                      textColor: AppColor.white,
                      fontSize: 14 * SizeConfig.textRatio,
                      height: 40 * SizeConfig.verticalBlock,
                      width: 100 * SizeConfig.horizontalBlock,
                      onPressed: () {
                        if (!jobsProvider.loading) jobsProvider.previousPage();
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 8 * SizeConfig.horizontalBlock,
                        vertical: 8 * SizeConfig.verticalBlock,
                      ),
                    ),
                    SizedBox(
                      width: 16 * SizeConfig.horizontalBlock,
                    ),
                    CustomButton(
                      text: "Next",
                      backgroundColor: AppColor.mainGreen,
                      textColor: AppColor.white,
                      fontSize: 14 * SizeConfig.textRatio,
                      height: 40 * SizeConfig.verticalBlock,
                      width: 100 * SizeConfig.horizontalBlock,
                      isDisable: !jobsProvider.hasMore,
                      onPressed: () {
                        if (!jobsProvider.loading) jobsProvider.nextPage();
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 8 * SizeConfig.horizontalBlock,
                        vertical: 8 * SizeConfig.verticalBlock,
                      ),
                    ),
                  ],
                ),
                (jobsProvider.loading)
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16 * SizeConfig.verticalBlock,
                        ),
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColor.mainBlue),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: jobsProvider.jobs.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<bool>(
                            future: getAppliedState(index),
                            builder: (context, snapshot) {
                              bool isApplied = snapshot.data ?? false;

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 16 * SizeConfig.verticalBlock,
                                  ),
                                  jobCard(jobsProvider.jobs[index], context,
                                      isApplied: isApplied),
                                  SizedBox(
                                    height: 16 * SizeConfig.verticalBlock,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
