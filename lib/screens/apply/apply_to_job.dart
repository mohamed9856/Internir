import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internir/services/fire_storage.dart';
import 'package:internir/utils/app_color.dart';
import 'package:internir/models/job_model.dart';

class ApplyToJob extends StatefulWidget {
  const ApplyToJob({super.key, required this.job});

  final JobModel job;
  static const String routeName = 'applyToJob';

  @override
  _ApplyToJobState createState() => _ApplyToJobState();
}

class _ApplyToJobState extends State<ApplyToJob> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _pickedFileName;
  String? _userImageURL;
  String? _username;
  String? _email;
  String? _phone;
  String? _category;
  bool _isFilePicked = false;
  bool _isLoading = false;
  Uint8List? file;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        setState(() {
          _userImageURL = doc['image'] as String? ?? '';  // Fallback to empty string if null
          _username = doc['username'] as String? ?? 'No name';  // Fallback to 'No name'
          _category = doc['category'] as String? ?? 'No category';
          _email = doc['email'] as String? ?? '';
          _phone = doc['phone'] as String? ?? '';
          _emailController.text = _email!;
          _phoneController.text = _phone!;
        });
      }
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        file = result.files.first.bytes;
        _pickedFileName = result.files.single.name;
        _isFilePicked = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected: $_pickedFileName')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

  void _uploadResume(BuildContext context) {
    if (_isFilePicked) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume uploaded!')),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick a file first!')),
      );
    }
  }

  Future<void> addJobToUserAppliedJobs(String userId, String jobId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'appliedJobs': FieldValue.arrayUnion([jobId]),
      });
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There has been an error!'),
        ),
      );
    }
  }

  Future<void> _sendApplication(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      if (!_isFilePicked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload your resume before applying!'),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      try {
        String companyId = widget.job.companyID;

        String email = _emailController.text.trim();
        String phone = _phoneController.text.trim();
        String? fileUrl;

        if (_isFilePicked) {
          fileUrl = await FireStorage.uploadFile(
            path: 'jobs/${widget.job.id}/applications/${FirebaseAuth.instance.currentUser!.uid}',
            fileName: _pickedFileName!,
            file: file!,
            contentType: 'application/pdf',
          );
        }

        Map<String, dynamic> applicationData = {
          'email': email,
          'phone': phone,
          'jobId': widget.job.id,
          'jobTitle': widget.job.title,
          'appliedAt': FieldValue.serverTimestamp(),
          'status': 'pending',
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'username': _username,
          'category': _category,
          'resume': fileUrl,
        };

        await FirebaseFirestore.instance
            .collection('company')
            .doc(companyId)
            .collection('jobs')
            .doc(widget.job.id)
            .collection('applications')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(applicationData);

        // Increase the number of applicants
        await FirebaseFirestore.instance
            .collection('jobs')
            .doc(widget.job.id)
            .update({'number of applicants': FieldValue.increment(1)});
        widget.job.numberOfApplicants += 1;

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await addJobToUserAppliedJobs(user.uid, widget.job.id);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application sent successfully!')),
        );

        setState(() {
          _pickedFileName = null;
          _isFilePicked = false;
        });

        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending application: $e')),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apply to ${widget.job.title}',
          overflow: TextOverflow.visible,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: _userImageURL != null && _userImageURL!.isNotEmpty
                        ? NetworkImage(_userImageURL!)
                        : null,
                    child: _userImageURL == null || _userImageURL!.isEmpty
                        ? const Icon(Icons.person, size: 32)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _username ?? 'No name',  // Default to 'No name'
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(_category ?? 'No category'),  // Default to 'No category'
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Resume',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Be sure to include an updated resume',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _pickFile,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: Text(
                      _pickedFileName ?? 'Choose Resume',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _uploadResume(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.lightBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(24),
                  ),
                  child: const Text('Upload Resume'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                    await _sendApplication(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.lightBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(24),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Send Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
