import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'user_details_model.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel? user;
  bool isEditButton;
  String? id;
  bool icon;

  UserDetailsPage({
    Key? key,
    this.user,
    this.id,
    this.icon = false,
    this.isEditButton = false,
  }) : super(key: key);

  List<String> genderOption = ['Male', 'Female', 'Other'];
  final _formKey = GlobalKey<FormState>();
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ViewModelBuilder<UserViewModel>.reactive(
          viewModelBuilder: () =>
              UserViewModel(currentUser: user ?? UserModel()),
          builder: ((context, viewModel, child) {
            return Scaffold(
              backgroundColor: const Color(0xff31363F),
              body: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          actions: [
                            if (icon)
                              IconButton(
                                  onPressed: () {
                                    if (icon) viewModel.deleteUserOnDb();
                                  },
                                  icon: const Icon(Icons.delete))
                          ],
                          floating: true,
                          snap: true,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          title: Text(user == null ? 'Add User' : 'Edit User',
                              style: GoogleFonts.archivo(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 26),
                              )),
                          centerTitle: true,
                        ),
                      ],
                  body: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width < 600
                                          ? 30
                                          : 200,
                                  vertical: 10),
                              child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: const Color(0xff76ABAE),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.newline,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                      labelText: "First Name",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                  obscureText: false,
                                  initialValue:
                                      viewModel.currentUser.firstName ?? '',
                                  onChanged: (value) {
                                    viewModel.currentUser.firstName = value;
                                    viewModel.rebuildUi();
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "First name can't be empty";
                                    }
                                    null;
                                    return null;
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width < 600
                                          ? 30
                                          : 200,
                                  vertical: 10),
                              child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: const Color(0xff76ABAE),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                      labelText: "Last Name",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                  obscureText: false,
                                  initialValue:
                                      viewModel.currentUser.lastName ?? '',
                                  onChanged: (value) {
                                    viewModel.currentUser.lastName = value;
                                    viewModel.rebuildUi();
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Last name can't be empty";
                                    }
                                    return null;
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width < 600
                                          ? 30
                                          : 200,
                                  vertical: 10),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                cursorColor: const Color(0xff76ABAE),
                                controller: viewModel.dateController,
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                onTap: () async {
                                  viewModel.datePicker(context);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xff76ABAE),
                                    ), // Border color when focused
                                  ),
                                  hintStyle: TextStyle(
                                      color: _isFocused
                                          ? Colors.blue
                                          : Colors.white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                              ),
                            ),
                            DropdownButtonFormField(
                                value: viewModel.currentUser.gender,
                                dropdownColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width < 600
                                            ? 30
                                            : 200,
                                    vertical: 10),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(
                                              0xff76ABAE)), // Border color when focused
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: _isFocused
                                                ? Color(0xff76ABAE)
                                                : Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                hint: Text(
                                  'Gender',
                                  style: TextStyle(
                                      color: _isFocused
                                          ? Colors.blue
                                          : Colors.white),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Select Gender';
                                  }
                                  return null;
                                },
                                items: genderOption.map((gender) {
                                  return DropdownMenuItem<String>(
                                    value: gender,
                                    child: Text(gender),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  viewModel.currentUser.gender = value;
                                  viewModel.rebuildUi();
                                }),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width < 600
                                          ? 30
                                          : 200,
                                  vertical: 10),
                              child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: const Color(0xff76ABAE),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      suffixIcon: const Icon(Icons.email),
                                      labelText: 'Email',
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                  initialValue:
                                      viewModel.currentUser.email ?? '',
                                  onChanged: (value) {
                                    viewModel.currentUser.email = value;
                                    viewModel.rebuildUi();
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
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width < 600
                                          ? 30
                                          : 200,
                                  vertical: 10),
                              child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.number,
                                  cursorColor: const Color(0xff76ABAE),
                                  decoration: InputDecoration(
                                      suffixIcon: const Icon(Icons.numbers),
                                      labelText: 'Phone Number',
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),

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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                  obscureText: false,
                                  initialValue:
                                      viewModel.currentUser.phoneNumber ?? '',
                                  onChanged: (
                                    value,
                                  ) {
                                    viewModel.currentUser.phoneNumber = value;
                                    viewModel.rebuildUi();
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Phone number can't be empty";
                                    }
                                    return null;
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width < 600
                                          ? 30
                                          : 200,
                                  vertical: 20),
                              child: Container(
                                height: 250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade800,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    cursorColor: const Color(0xff76ABAE),
                                    keyboardType: TextInputType.multiline,
                                    enabled: true,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      hintText: "Note Something...",
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabled: true,
                                      border: InputBorder.none,
                                    ),
                                    textInputAction: TextInputAction.newline,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    initialValue:
                                        viewModel.currentUser.userNote ?? '',
                                    onChanged: (value) {
                                      viewModel.currentUser.userNote = value;
                                      viewModel.rebuildUi();
                                    },
                                    obscureText: false,
                                    validator: (value) {
                                      value!.isEmpty ? '' : null;
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (!isEditButton) // Show the update button only in edit mode
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        viewModel.updateUserOnDb();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 40,
                                        width: 95,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(23),
                                          color: const Color(0xff76ABAE),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Update',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (isEditButton)
                                  GestureDetector(
                                    onTap: () async {
                                      // Validate form fields
                                      if (_formKey.currentState!.validate()) {
                                        viewModel.createUserOnDB();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 40,
                                        width: 95,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(23),
                                          color: const Color(0xff76ABAE),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Add',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          ])))),
            );
          })));
}
