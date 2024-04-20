import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_practice_application/models/user_details_model.dart';

import 'package:flutter_practice_application/ui_helper/ui_helper_model.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController pnumberController = TextEditingController();
final TextEditingController userNoteController = TextEditingController();

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Add Task',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                UiHelper.CustomTextFieldWithIconInRow(
                  firstNameController,
                  false,
                  'First Name',
                ),
                UiHelper.CustomTextFieldWithIconInRow(
                  lastNameController,
                  false,
                  'Last Name',
                ),
              ],
            ),
            UiHelper.CustomTextFieldWithIcon(emailController, false, 'Email',
                Icons.person_2_outlined, TextInputType.emailAddress),
            UiHelper.CustomTextFieldWithIcon(pnumberController, false,
                'Phone Number', Icons.numbers, TextInputType.number),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: UiHelper.CustomUserNote(
                    userNoteController, false, 'Note Something...'),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                onTap: () {
                  // Get the text values from the controllers
                  String firstName = firstNameController.text.trim();
                  String lastName = lastNameController.text.trim();
                  String email = emailController.text.trim();
                  String phoneNumber = pnumberController.text.trim();
                  String userNote = userNoteController.text.trim();
                  // condition if empty them showDialog
                  if (firstName.isEmpty ||
                      lastName.isEmpty ||
                      email.isEmpty ||
                      phoneNumber.isEmpty ||
                      userNote.isEmpty) {
                    showDialog(
                      context: context,
                      builder: ((context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(fontSize: 23),
                                  ))
                            ],
                            title:
                                const Text('Please fill the required blanks'),
                          )),
                    );
                  } else {
                    // else add user data with provider and model of userdetails
                    final userDetailsModel =
                        Provider.of<UserDetailsModel>(context, listen: false);
                    userDetailsModel.addUserDetails(
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      email: emailController.text.trim(),
                      phoneNumber: pnumberController.text.trim(),
                      userNote: userNoteController.text.trim(),
                    );
                    Navigator.pop(context);
                  }
                  // clear fields when close page
                  firstNameController.clear();
                  lastNameController.clear();
                  emailController.clear();
                  pnumberController.clear();
                  userNoteController.clear();
                },
                // add task button.
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.purple,
                    ),
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
