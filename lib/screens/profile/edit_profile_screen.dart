import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internir/components/custom_button.dart';
import 'package:internir/components/custom_text_form_field.dart';
import 'package:internir/constants/constants.dart';
import 'package:internir/screens/profile/profile_screen.dart';
import 'package:internir/screens/profile/widgets/profile_pic.dart';
import 'package:internir/utils/app_color.dart';
import '../../utils/size_config.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  bool isLoading = false;

  //----GET DATA----\\
  Future<void> getData() async {
    if (currentUser != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.uid)
            .get();

        setState(() {
          usernameController.text = userDoc['username'];
          categoryController.text = userDoc['category'];
          phoneNumberController.text = userDoc['phone'];
          isLoading = false;
        });
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  //----UPDATE DATA----\\
  Future<void> updateData() async {
    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .update({
          'username': usernameController.text.trim(),
          'phone': phoneNumberController.text.trim(),
          'category': categoryController.text.trim(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context, {
          'username': usernameController.text.trim(),
          'phone': phoneNumberController.text.trim(),
          'category': categoryController.text.trim(),
        });
      } catch (e) {
        print("Error updating user data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile.')),
        );
      }
    }
  }

  //----JOB CATEGORIES----\\
  void _showSelectOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: ListView.builder(
            itemCount: listCategories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listCategories[index]),
                onTap: () {
                  setState(() {
                    categoryController.text = listCategories[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: const Text('Edit Profile',
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        iconTheme: const IconThemeData(size: 30, color: AppColor.black),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        color: AppColor.background,
        child: ListView(
          children: [
            //----EDIT PROFILE PIC----\\
            const ProfilePicture(),
            SizedBox(height: SizeConfig.screenHeight * 0.036),

            //----USERNAME FIELD----\\
            const Text('Username',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: SizeConfig.screenHeight * 0.008),
            customTextFormField(controller: usernameController),
            SizedBox(height: SizeConfig.screenHeight * 0.016),

            //----PHONE NUMBER FIELD----\\
            const Text('Phone Number',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: SizeConfig.screenHeight * 0.008),
            customTextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone),
            SizedBox(height: SizeConfig.screenHeight * 0.016),

            //----CATEGORY FIELD----\\
            const Text('Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: SizeConfig.screenHeight * 0.008),
            customTextFormField(
                controller: categoryController,
                readOnly: true,
                onTap: () {
                  _showSelectOptions(context);
                },
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                )),

            //----SAVED BUTTON----\\
            SizedBox(height: SizeConfig.screenHeight * 0.230),
            CustomButton(
              text: 'Save Changes',
              onPressed: updateData,
              fontSize: 25,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
            )
          ],
        ),
      ),
    );
  }
}
