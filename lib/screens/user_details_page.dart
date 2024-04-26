import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:intl/intl.dart';

class UserDetails extends StatefulWidget {
  final User? user;

  const UserDetails({Key? key, this.user}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

TextEditingController dateController = TextEditingController();

@override
void dispose() {
  // Dispose the controller when not needed
  dateController.dispose();
}

class _UserDetailsState extends State<UserDetails> {
  late User currentUser;
  // String? selectedGender;
  List<String> genderOption = ['Male', 'Female', 'Other'];
  final _formKey = GlobalKey<FormState>();
  bool _isFocused = false;
  Color textColor = Colors.black;
  @override
  void initState() {
    super.initState();
    currentUser = widget.user ?? User();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xff31363F),
          body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      title: Text(
                        widget.user == null ? 'Add User' : 'Edit User',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),
                      ),
                      centerTitle: true,
                    ),
                  ],
              body: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 27, vertical: 10),
                          child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              cursorColor: const Color(0xff76ABAE),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.newline,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  hintText: "First Name",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xff76ABAE),
                                    ), // Border color when focused
                                  ),
                                  hintStyle: TextStyle(
                                      color: _isFocused
                                          ? Colors.blue
                                          : Colors.white),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              obscureText: false,
                              initialValue: currentUser.firstName ?? '',
                              onChanged: (value) {
                                setState(() {
                                  currentUser.firstName = value;
                                });
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "First name can't be empty";
                                }
                                null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 27, vertical: 10),
                          child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              cursorColor: const Color(0xff76ABAE),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  hintText: "Last Name",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xff76ABAE),
                                    ), // Border color when focused
                                  ),
                                  hintStyle: TextStyle(
                                      color: _isFocused
                                          ? Colors.blue
                                          : Colors.white),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              obscureText: false,
                              initialValue: currentUser.lastName ?? '',
                              onChanged: (value) {
                                setState(() {
                                  currentUser.lastName = value;
                                });
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Last name can't be empty";
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 27, vertical: 10),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: const Color(0xff76ABAE),
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  dateController.text = DateFormat('yyy-MM-dd')
                                      .format(pickedDate);
                                  currentUser.dateOfBirth = pickedDate;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Date of Birth',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xff76ABAE),
                                ), // Border color when focused
                              ),
                              hintStyle: TextStyle(
                                  color:
                                      _isFocused ? Colors.blue : Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 27, vertical: 10),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            hint: Text(
                              'Gender',
                              style: TextStyle(
                                  color:
                                      _isFocused ? Colors.blue : Colors.white),
                            ),
                            style: const TextStyle(color: Colors.white),
                            // value: selectedGender,
                            items: genderOption.map((gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onChanged: (value) {
                              currentUser.gender = value;
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 27, vertical: 10),
                          child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              cursorColor: const Color(0xff76ABAE),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.email),
                                  hintText: 'Email',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xff76ABAE),
                                    ), // Border color when focused
                                  ),
                                  hintStyle: TextStyle(
                                      color: _isFocused
                                          ? Colors.blue
                                          : Colors.white),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              initialValue: currentUser.email ?? '',
                              onChanged: (value) {
                                setState(() {
                                  currentUser.email = value;
                                });
                              },
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
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              cursorColor: const Color(0xff76ABAE),
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.numbers),
                                  hintText: 'Phone Number',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),

                                    borderSide: const BorderSide(
                                      color: Color(0xff76ABAE),
                                    ), // Border color when focused
                                  ),
                                  hintStyle: TextStyle(
                                      color: _isFocused
                                          ? Colors.blue
                                          : Colors.white),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              obscureText: false,
                              initialValue: currentUser.phoneNumber ?? '',
                              onChanged: (
                                value,
                              ) {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade800,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Stack(
                                children: [
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: const Color(0xff76ABAE),
                                    keyboardType: TextInputType.multiline,
                                    enabled: true,
                                    maxLines: 20,
                                    decoration: InputDecoration(
                                      hintText: "Note Something...",
                                      hintStyle: TextStyle(
                                          color: _isFocused
                                              ? Colors.blue
                                              : Colors.white),
                                      enabled: true,
                                      border: InputBorder.none,
                                    ),
                                    textInputAction: TextInputAction.newline,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    initialValue: currentUser.userNote ?? '',
                                    onChanged: (value) {
                                      setState(() {
                                        currentUser.userNote = value;
                                      });
                                    },
                                    obscureText: false,
                                    validator: (value) {
                                      value!.isEmpty ? '' : null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // Validate form fields
                                    if (_formKey.currentState!.validate()) {
                                      // Handle saving or updating user data here
                                      Navigator.pop(context,
                                          currentUser); // Return updated user object
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        color: const Color(0xff76ABAE),
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
                      ])))),
        ),
      );
}
