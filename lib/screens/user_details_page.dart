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
final _formKey = GlobalKey<FormState>();

class _UserDetailsState extends State<UserDetails> {
  String? firstName, lastName, email, pnumber, userNote;
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 10),
                    child: Container(
                      height: 75,
                      width: 145,
                      child: Center(
                        child: TextFormField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                                hintText: "First Name",
                                enabled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            obscureText: false,
                            onChanged: (value) {
                              firstName = value;
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "can't be empty";
                              }
                              null;
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 10),
                    child: Container(
                      height: 75,
                      width: 145,
                      child: Center(
                        child: TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                                hintText: "Last Name",
                                enabled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            obscureText: false,
                            // onChanged: (value) {
                            //   lastName = value;
                            // },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "can't be empty";
                              }
                              return null;
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
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
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return " Email can't be empty";
                      }
                      return null;
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: emailController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.numbers),
                        hintText: 'Phone Number',
                        enabled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    obscureText: false,
                    onChanged: (value) {
                      pnumber = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Phone number can't be empty";
                      }
                      null;
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      enabled: true,
                      maxLines: 20,
                      controller: userNoteController,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Note Something",
                        enabled: true,
                        border: InputBorder.none,
                      ),
                      obscureText: false,
                      onChanged: (value) {
                        userNote = value;
                      },
                      validator: (value) {
                        value!.isEmpty ? '' : null;
                      },
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
                    if (_formKey.currentState!.validate()) {
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
      ),
    );
  }
}
