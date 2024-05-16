import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_application/view_models/home_model.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:flutter_practice_application/services/user_db_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_practice_application/views/user_details_views.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<UserModel> userDetailList = [];
late UserDBService userDB;
final ref = FirebaseFirestore.instance.collection('users').snapshots();

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    userDB = UserDBService();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 38, 42, 49),
            appBar: AppBar(
              backgroundColor: const Color(0xff76ABAE),
              title: Text('User Details',
                  style: GoogleFonts.archivo(
                    textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              centerTitle: false,
              foregroundColor: Colors.white,
            ),
            body: Column(children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: ref,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return Text('Error: ${snapshot.error}');
                    }
                    List<UserModel> users = snapshot.data!.docs
                        .map((doc) => UserModel.fromSnapshot(
                            doc as DocumentSnapshot<Map<String, dynamic>>))
                        .toList();
                    return ScreenTypeLayout.builder(
                      mobile: (BuildContext context) => mobile(users),
                      tablet: (BuildContext context) => tablet(users),
                      desktop: (BuildContext context) => desktop(users),
                    );
                  },
                ),
              ),
            ]),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff76ABAE),
              onPressed: () async {
                // Navigate to UserDetails and wait for result
                final newUser = await Navigator.push<UserModel>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsPage(
                            isEditButton: true,
                          )),
                );

                if (newUser != null) {
                  setState(() {
                    userDetailList.add(newUser);
                  });
                }
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        });
  }

  Widget mobile(List<UserModel> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        UserModel user = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(
                    user: user,
                    id: user.id,
                    icon: true,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 38, 42, 49),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff76ABAE),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xff76ABAE),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(174, 15, 14, 14),
                                ),
                              ),
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: GoogleFonts.archivo(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.email_rounded,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            '${user.email}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.phone,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            '${user.phoneNumber}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.male,
                                color: Color.fromARGB(174, 15, 14, 14),
                              ),
                            ),
                            Text(
                              '${user.gender}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 14.0,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.date_range,
                                color: Color.fromARGB(174, 15, 14, 14),
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(user.dateOfBirth!),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ]),
                      const SizedBox(height: 5),
                      if (user.userNote != null) ...[
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Visibility(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(240, 238, 227, 124),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                child: Text(
                                  '${user.userNote}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget desktop(List<UserModel> users) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(
                    user: user,
                    id: user.id,
                    icon: true,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 38, 42, 49),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff76ABAE),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xff76ABAE),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(174, 15, 14, 14),
                                ),
                              ),
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: GoogleFonts.archivo(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.email_rounded,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            '${user.email}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.phone,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            '${user.phoneNumber}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.male,
                                color: Color.fromARGB(174, 15, 14, 14),
                              ),
                            ),
                            Text(
                              '${user.gender}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 14.0,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.date_range,
                                color: Color.fromARGB(174, 15, 14, 14),
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(user.dateOfBirth!),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ]),
                      const SizedBox(height: 5),
                      if (user.userNote != null) ...[
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Visibility(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(240, 238, 227, 124),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                child: Text(
                                  '${user.userNote}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget tablet(List<UserModel> users) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailsPage(
                  user: user,
                  id: user.id,
                  icon: true,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 38, 42, 49),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff76ABAE),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xff76ABAE),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.person,
                                color: Color.fromARGB(174, 15, 14, 14),
                              ),
                            ),
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: GoogleFonts.archivo(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.email_rounded,
                            color: Color.fromARGB(174, 15, 14, 14),
                          ),
                        ),
                        Text(
                          '${user.email}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.phone,
                            color: Color.fromARGB(174, 15, 14, 14),
                          ),
                        ),
                        Text(
                          '${user.phoneNumber}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.male,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            '${user.gender}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 14.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.date_range,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(user.dateOfBirth!),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ]),
                    const SizedBox(height: 5),
                    if (user.userNote != null) ...[
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Visibility(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(240, 238, 227, 124),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              child: Text(
                                '${user.userNote}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
