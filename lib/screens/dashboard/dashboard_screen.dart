import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/size_config.dart';
import '../../providers/jobs_provider.dart';
import '../../providers/Admin/company_auth_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String routeName = 'dashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobsProvider>(context, listen: false).fetchJobs();
      Provider.of<CompnayAuthProvider>(context, listen: false).initCompany(); // Initialize company data
    });
  }

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobsProvider>(context);
    var companyProvider = Provider.of<CompnayAuthProvider>(context);

    // Fallback values for company name and image
    String name = companyProvider.company.name ?? "Loading...";
    String? companyImage = companyProvider.company.image;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: Text(
          'Welcome to dashboard',
          style: TextStyle(
            color: AppColor.mainBlue,
            fontSize: 20 * SizeConfig.textRatio,
            fontWeight: FontWeight.bold,
            fontFamily: 'NotoSans',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0 * SizeConfig.horizontalBlock),
            child: Row(
              children: [
                Text(
                  '$name\nAdmin',
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 15 * SizeConfig.textRatio,
                    fontFamily: 'NotoSans',
                  ),
                ),
                SizedBox(width: 10 * SizeConfig.horizontalBlock),
                CircleAvatar(
                  backgroundImage: (companyImage != null && companyImage.isNotEmpty)
                      ? (companyProvider.isNetworkImage()
                      ? NetworkImage(companyImage)
                      : const AssetImage(AppAssets.noProfileImage) as ImageProvider)
                      : const AssetImage(AppAssets.noProfileImage), // Fallback image
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * SizeConfig.horizontalBlock),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Internships',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 22 * SizeConfig.textRatio,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSans',
                ),
              ),
              SizedBox(height: 20 * SizeConfig.verticalBlock),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainBlue,
                ),
                child: const Text(
                  'Add New Internship',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20 * SizeConfig.verticalBlock),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Internship title')),
                      DataColumn(label: Text('Location')),
                      DataColumn(label: Text('Number of applicants')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: jobProvider.jobs.map((job) {
                      return DataRow(cells: [
                        DataCell(Text(job.title)),
                        DataCell(Text(job.location)),
                        DataCell(Text(job.numberOfApplicants.toString())),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.mainBlue,
                            ),
                            child: const Text(
                              'View Internship',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              if (jobProvider.loading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
