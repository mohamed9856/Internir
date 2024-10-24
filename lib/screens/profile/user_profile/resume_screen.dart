import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internir/components/custom_button.dart';
import 'package:internir/screens/profile/widgets/my_pdf_card.dart';
import 'package:internir/utils/size_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../utils/app_color.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  List<File> uploadedFiles = [];
  List<String> uploadedFileUrls = []; // List to store URLs of uploaded files
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchUploadedFiles(); // Fetch files when the page loads
  }

  // Fetch uploaded files from Firestore
  Future<void> fetchUploadedFiles() async {
    if (currentUser != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).get();
      if (snapshot.exists && snapshot.data() != null) {
        var data = snapshot.data() as Map<String, dynamic>;
        if (data.containsKey('uploadedFiles')) {
          setState(() {
            uploadedFileUrls = List<String>.from(data['uploadedFiles']);
            uploadedFiles = []; // Reset the local files list
          });
          for (var url in uploadedFileUrls) {
            // Create a dummy file from the URLs
            // You might want to modify this as per your needs
            uploadedFiles.add(File(url)); // Note: This may not work as expected
          }
        }
      }
    }
  }

  //----UPLOAD FILE----\\
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      await uploadPdf(file); // Upload PDF
      setState(() {
        uploadedFiles.add(file); // Add the file to the local list
      });
    }
  }

  // Function to upload PDF
  Future<void> uploadPdf(File file) async {
    try {
      Reference ref = FirebaseStorage.instance.ref('resumes/${file.path.split('/').last}');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      if (currentUser != null) {
        // Save the download URL in Firestore
        await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).update({
          'uploadedFiles': FieldValue.arrayUnion([downloadUrl]),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF uploaded successfully!')));
    } catch (e) {
      print("Error uploading PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to upload PDF.')));
    }
  }

  //----REMOVE FILE----\\
  void removeFile(File file) {
    setState(() {
      uploadedFiles.remove(file);
    });
    // Update Firestore to remove the URL
    if (currentUser != null) {
      FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).update({
        'uploadedFiles': FieldValue.arrayRemove([file.path]), // Adjust as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resume',
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: AppColor.background,
        centerTitle: true,
        iconTheme: const IconThemeData(size: 30, color: AppColor.black),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        color: AppColor.background,
        child: ListView(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.8,
              child: ListView.builder(
                  itemCount: uploadedFiles.length,
                  itemBuilder: (context, index) {
                    final file = uploadedFiles[index];
                    return MyPdf(
                      file: file,
                      onDelete: () => removeFile(file),
                    );
                  }
              ),
            ),

            //----UPLOAD BUTTON----\\
            CustomButton(
                text: 'Upload Resume',
                fontSize: 25,
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                backgroundColor: AppColor.indigo,
                textColor: AppColor.lightGrey,
                onPressed: () async {
                  await uploadFile();
                }
            )
          ],
        ),
      ),
    );
  }
}