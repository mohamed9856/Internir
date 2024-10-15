import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplyScreen extends StatelessWidget {
  final String jobId;

  const ApplyScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('jobs').doc(jobId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Job not found'),);
        }

        var jobData = snapshot.data!.data() as Map<String, dynamic>;

        String formattedDate = jobData['createdAt'] != null
            ? DateFormat.yMMMMd().add_jm().format(jobData['createdAt'].toDate())
            : 'No date';

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        jobData['title'] ?? 'No title',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        jobData['company'] ?? 'No company',
                        style: const TextStyle(fontSize: 16, color: Colors.grey,),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Salary: \$${jobData['salary']?.toString() ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16, color: Colors.grey,),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        jobData['category'] ?? 'No category',
                        style: const TextStyle(fontSize: 16, color: Colors.grey,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildSectionTitle('Job Description:'),
                Text(
                  jobData['description'] ?? 'No description available',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),

                _buildSectionTitle('Job Type:'),
                Text(
                  jobData['job type'] ?? 'No job type',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),

                _buildSectionTitle('Location:'),
                Text(
                  jobData['location'] ?? 'No location',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),

                _buildSectionTitle('Created At:'),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),

                _buildSectionTitle('Number of Applicants:'),
                Text(
                  '${jobData['number of applicants'] ?? 0}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),

                // Enabled (Job status)
                _buildSectionTitle('Job Enabled:'),
                Text(
                  jobData['enabled'] == true ? 'Yes' : 'No',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
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
