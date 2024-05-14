import 'package:client_quick_food/components/my_text_button.dart';
import 'package:client_quick_food/components/sec_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.userId});
  final String userId;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String psd = '';
  @override
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await getPassword();
  }

  Future<void> getPassword() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: widget.userId)
        .get();
    var user = querySnapshot.docs.first.data() as Map<String, dynamic>;

    setState(() {
      psd = user['password'];
    });
  }

  Widget build(BuildContext context) {
    GlobalKey<FormState> myFormState = GlobalKey<FormState>();
    TextEditingController oldPsswd = TextEditingController();
    TextEditingController newpsswd = TextEditingController();
    TextEditingController confirmenewpsswd = TextEditingController();

    void _submit() async {
      final valid = myFormState.currentState!.validate();

      if (!valid) {
        return;
      }
      await FirebaseAuth.instance.currentUser!
          .updatePassword(newpsswd.text.trim());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update({
        'password': newpsswd.text.trim(),
      });
      myFormState.currentState!.save();
      Navigator.of(context).pop();
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
                  child: Form(
                    key: myFormState,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        MyTextField(
                          myIcon: Icons.password,
                          myController: oldPsswd,
                          isObscure: true,
                          etiquette: 'Old passwoed',
                          myValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password.';
                            }

                            if (value != psd) {
                              return 'the old password isn\'t correct.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        MyTextField(
                          myIcon: Icons.password,
                          myController: newpsswd,
                          isObscure: true,
                          etiquette: 'New password',
                          myValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password.';
                            }
                            if (value.length < 6) {
                              return 'The password must contain at least 6 characters.';
                            }
                            if (value == psd) {
                              return 'Same as old password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 38.0,
                        ),
                        MyTextField(
                          myIcon: Icons.password,
                          myController: confirmenewpsswd,
                          isObscure: true,
                          etiquette: 'confirm old password',
                          myValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password.';
                            }
                            if (value != newpsswd.text.trim()) {
                              return 'Password confirmation does not match.';
                            }
                            return null;
                          },
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
