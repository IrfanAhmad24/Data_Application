import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_application/models/user_model.dart';

class UserDetails extends StatefulWidget {
  final User? user;

  const UserDetails({Key? key, this.user}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

final _formKey = GlobalKey<FormState>();

class _UserDetailsState extends State<UserDetails> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController pnumberController;
  late TextEditingController userNoteController;

  @override
  void initState() {
    super.initState();
    firstNameController =
        TextEditingController(text: widget.user?.firstName ?? '');
    lastNameController =
        TextEditingController(text: widget.user?.lastName ?? '');
    emailController = TextEditingController(text: widget.user?.email ?? '');
    pnumberController =
        TextEditingController(text: widget.user?.phoneNumber ?? '');
    userNoteController =
        TextEditingController(text: widget.user?.userNote ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            widget.user == null ? 'Add User' : 'Edit User',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 10),
                    child: TextFormField(
                        controller: firstNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: "First Name",
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "can't be empty";
                          }
                          null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 10),
                    child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        controller: lastNameController,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "can't be empty";
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 10),
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.email),
                            hintText: 'Email',
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return " Email can't be empty";
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 10),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: pnumberController,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.numbers),
                            hintText: 'Phone Number',
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Phone number can't be empty";
                          }
                          null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          enabled: true,
                          maxLines: 20,
                          controller: userNoteController,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Note Something",
                            enabled: true,
                            border: InputBorder.none,
                          ),
                          obscureText: false,
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
                          // Validate form fields
                          if (widget.user == null) {
                            // Add new user
                            User newUser = User(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              phoneNumber: pnumberController.text,
                              userNote: userNoteController.text,
                            );
                            Navigator.pop(
                                context, newUser); // Return new user object
                          } else {
                            // Update existing user
                            User updatedUser = User(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              phoneNumber: pnumberController.text,
                              userNote: userNoteController.text,
                            );
                            Navigator.pop(context,
                                updatedUser); // Return updated user object
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              color: Colors.deepPurple,
                            ),
                            child: Center(
                                child: Text(
                              widget.user == null ? 'Add' : 'Update',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19),
                            )),
                          ),
                        )),
                  ]),
                ]))));
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    pnumberController.dispose();
    userNoteController.dispose();
    super.dispose();
  }
}
