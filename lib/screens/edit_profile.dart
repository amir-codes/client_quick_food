// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element, use_build_context_synchronously

import 'dart:io';

import 'package:client_quick_food/components/my_text_button.dart';
import 'package:client_quick_food/components/sec_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key, this.profilePicture, required this.userId});
  String? profilePicture;
  final String userId;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> myFormState = GlobalKey<FormState>();
    TextEditingController userName = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();

    @override
    void dispose() {
      userName.dispose();
      email.dispose();
      phone.dispose();
      super.dispose();
    }

    CircleAvatar _buildCircleAvatar() {
      if (widget.profilePicture == '') {
        return const CircleAvatar(
          radius: 50,
        );
      } else {
        return CircleAvatar(
          backgroundImage: NetworkImage(widget.profilePicture!),
          radius: 50,
        );
      }
    }

    void _submit() async {
      final valid = myFormState.currentState!.validate();

      if (!valid) {
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update({
        'imageUrl': widget.profilePicture,
        'username': userName.text.trim(),
        'phone number': phone.text.trim()
      });
      myFormState.currentState!.save();
      Navigator.of(context).pop();
    }

    Future _pickImageFromGallery() async {
      File? _selectedImage;
      final _firebase = FirebaseAuth.instance;
      final returnedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (returnedImage == null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please pick image first')));
      }
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child('${returnedImage!.name}.jpg');

      _selectedImage = File(returnedImage.path);

      await storageRef.putFile(_selectedImage);
      final fctImageUrl = await storageRef.getDownloadURL();

      setState(() {
        widget.profilePicture = fctImageUrl;
      });
      print('image url is ${widget.profilePicture}');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update({
        'imageUrl': widget.profilePicture,
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(widget.profilePicture == ''
              ? 'Upload failed'
              : 'upload seuccessfuly')));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Stack(
                    children: [
                      _buildCircleAvatar(),
                      Positioned(
                        bottom: -5,
                        left: 85,
                        child: Container(
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () {
                              _pickImageFromGallery();
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 32,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Form(
                key: myFormState,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50.0,
                    ),
                    MyTextField(
                      myIcon: Icons.person,
                      myController: userName,
                      isObscure: false,
                      etiquette: 'Name',
                      myValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can\'t be empty.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    MyTextField(
                      myIcon: Icons.phone,
                      myController: phone,
                      isObscure: false,
                      etiquette: 'Phone',
                    ),
                    const SizedBox(
                      height: 38.0,
                    ),
                    Center(
                        child: MyTextButton(
                      mybuttonLabel: 'Save Changes',
                      myOnpressedFct: () {
                        _submit();
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
