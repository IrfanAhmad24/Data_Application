import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_practice_application/models/user_model.dart';

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

List<User> userDetailList = [];

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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
                  child: Container(
                    height: 75,
                    width: 145,
                    child: Center(
                      child: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            hintText: "First Name",
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
                  child: Container(
                    height: 75,
                    width: 145,
                    child: Center(
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: pnumberController,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.numbers),
                    hintText: 'Phone Number',
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    enabled: true,
                    maxLines: 20,
                    controller: userNoteController,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Note Something",
                      enabled: true,
                      border: InputBorder.none,
                    ),
                    obscureText: false,
                  ),
                ),
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
                    User newUser = User(
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                      phoneNumber: phoneNumber,
                      userNote: userNote,
                    );

                    setState(() {
                      userDetailList.add(newUser);
                    });
                    Navigator.pop(context, newUser);
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
