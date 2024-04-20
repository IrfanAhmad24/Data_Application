import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_practice_application/models/user_model.dart';

class UserDetails extends StatefulWidget {
  final User? user;
  const UserDetails({super.key, this.user});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _formKey = GlobalKey<FormState>();
  List<User> userDetailList = [];
  var currentUser = User();

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pnumberController = TextEditingController();
    final TextEditingController userNoteController = TextEditingController();

    @override
    void initState() {
      super.initState();
      firstNameController.text = widget.user?.firstName ?? '';
      lastNameController.text = widget.user?.lastName ?? '';
      emailController.text = widget.user?.email ?? '';
      pnumberController.text = widget.user?.phoneNumber ?? '';
      userNoteController.text = widget.user?.userNote ?? '';
    }

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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: "First Name",
                        enabled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {
                        currentUser.firstName = value;
                      });
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "can't be empty";
                      }
                      null;
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
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
                    onChanged: (value) {
                      setState(() {
                        currentUser.lastName = value;
                      });
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "can't be empty";
                      }
                      return null;
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
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
                    onChanged: (value) {
                      setState(() {
                        currentUser.email = value;
                      });
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
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
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
                    onChanged: (value) {
                      setState(() {
                        currentUser.phoneNumber = value;
                      });
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
                      onChanged: (value) {
                        setState(() {
                          currentUser.userNote = value;
                        });
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
                    // condition if empty them showDialog
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        userDetailList.add(currentUser);
                      });

                      Navigator.pop(context, currentUser);
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
                Container(
                  height: 50,
                  width: 95,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ElevatedButton(
                    onPressed: () {
                      // Update user details and pop screen with updated user
                      User updatedUser = User(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        phoneNumber: pnumberController.text,
                        userNote: userNoteController.text,
                      );
                      Navigator.pop(context, updatedUser);
                    },
                    child: Text('Save'),
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
