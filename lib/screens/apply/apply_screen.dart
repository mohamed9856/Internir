import 'package:flutter/material.dart';
import 'package:internir/models/job_model.dart';
import 'package:internir/screens/apply/apply_to_job.dart';
import 'package:internir/utils/app_color.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key, required this.job});

  final JobModel job;
  static const String routeName = 'applyScreen';

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  bool isJobSaved = false;

  void saveJob() {
    setState(() {
      isJobSaved = !isJobSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Image(
                            image: NetworkImage(
                              'https://dummyimage.com/300x200/000/fff',
                            ),
                            fit: BoxFit.cover,
                            width: 104,
                            height: 104,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.job.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.job.company,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Salary: \$${widget.job.salary?.toString() ?? 'N/A'}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Job Description:'),
                  Text(
                    widget.job.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Job Type:'),
                  Text(
                    widget.job.jobType ?? 'No job type',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Location:'),
                  Text(
                    widget.job.location,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Created At:'),
                  Text(
                    '${widget.job.createdAt.month} / ${widget.job.createdAt.year}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Number Of Applicants:'),
                  Text(
                    widget.job.numberOfApplicants.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Category:'),
                  Text(
                    widget.job.category ?? 'No category specified',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Enabled:'),
                  Text(
                    widget.job.enabled.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: saveJob,
                    icon: isJobSaved
                        ? const Icon(Icons.bookmark, color: Colors.blue)
                        : const Icon(Icons.bookmark_border, color: Colors.grey),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.lightBlue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          ApplyToJob.routeName,
                          arguments: widget.job,
                        );
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
