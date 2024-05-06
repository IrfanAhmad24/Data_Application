import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_practice_application/screens/user_details.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = User();
  List<User> userDetailList = [];
  final firestore = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) {
          return mobile();
        },
        tablet: (context) {
          return tablet();
        },
        desktop: (context) {
          return desktop();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff76ABAE),
        onPressed: () async {
          // Navigate to UserDetails and wait for result
          final newUser = await Navigator.push<User>(
            context,
            MaterialPageRoute(
                builder: (context) => UserDetailsPage(
                      isEditButton: true,
                    )),
          );

          // Add new user to the list if user is not null
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
  }

  Widget mobile() {
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
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    String id = snapshot.data!.docs[index]['id'].toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailsPage(
                                        user: User(
                                          firstName: snapshot.data!.docs[index]
                                              ['firstName'],
                                          lastName: snapshot.data!.docs[index]
                                              ['lastName'],
                                          email: snapshot.data!.docs[index]
                                              ['email'],
                                          gender: snapshot.data!.docs[index]
                                              ['gender'],
                                          phoneNumber: snapshot
                                              .data!.docs[index]['phoneNumber'],
                                          userNote: snapshot.data!.docs[index]
                                              ['userNote'],
                                          // Assuming 'birth' is the field for date of birth
                                          dateOfBirth: DateTime.parse(snapshot
                                              .data!.docs[index]['birth']),
                                        ),
                                        id: id,
                                        icon: true,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.person,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ['firstName']
                                                        .toString(),
                                                    style: GoogleFonts.archivo(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .docs[index]['lastName']
                                                        .toString(),
                                                    style: GoogleFonts.archivo(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['birth']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.email_rounded,
                                          color:
                                              Color.fromARGB(174, 15, 14, 14),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['email']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.male,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.docs[index]['gender']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.phone,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!
                                                  .docs[index]['phoneNumber']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  if (snapshot.data!.docs[index]['userNote'] !=
                                      null) ...[
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Visibility(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                240, 238, 227, 124),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Text(
                                              snapshot
                                                  .data!.docs[index]['userNote']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
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
                  });
            },
          ),
        )
      ]),
    );
  }

  Widget desktop() {
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
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    String id = snapshot.data!.docs[index]['id'].toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailsPage(
                                        user: User(
                                          firstName: snapshot.data!.docs[index]
                                              ['firstName'],
                                          lastName: snapshot.data!.docs[index]
                                              ['lastName'],
                                          email: snapshot.data!.docs[index]
                                              ['email'],
                                          gender: snapshot.data!.docs[index]
                                              ['gender'],
                                          phoneNumber: snapshot
                                              .data!.docs[index]['phoneNumber'],
                                          userNote: snapshot.data!.docs[index]
                                              ['userNote'],
                                          // Assuming 'birth' is the field for date of birth
                                          dateOfBirth: DateTime.parse(snapshot
                                              .data!.docs[index]['birth']),
                                        ),
                                        id: id,
                                        icon: true,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.person,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ['firstName']
                                                        .toString(),
                                                    style: GoogleFonts.archivo(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .docs[index]['lastName']
                                                        .toString(),
                                                    style: GoogleFonts.archivo(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['birth']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.email_rounded,
                                          color:
                                              Color.fromARGB(174, 15, 14, 14),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['email']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.male,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.docs[index]['gender']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.phone,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!
                                                  .docs[index]['phoneNumber']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  if (snapshot.data!.docs[index]['userNote'] !=
                                      null) ...[
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Visibility(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                240, 238, 227, 124),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Text(
                                              snapshot
                                                  .data!.docs[index]['userNote']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
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
                  });
            },
          ),
        )
      ]),
    );
  }

  Widget tablet() {
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
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    String id = snapshot.data!.docs[index]['id'].toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailsPage(
                                        user: User(
                                          firstName: snapshot.data!.docs[index]
                                              ['firstName'],
                                          lastName: snapshot.data!.docs[index]
                                              ['lastName'],
                                          email: snapshot.data!.docs[index]
                                              ['email'],
                                          gender: snapshot.data!.docs[index]
                                              ['gender'],
                                          phoneNumber: snapshot
                                              .data!.docs[index]['phoneNumber'],
                                          userNote: snapshot.data!.docs[index]
                                              ['userNote'],
                                          // Assuming 'birth' is the field for date of birth
                                          dateOfBirth: DateTime.parse(snapshot
                                              .data!.docs[index]['birth']),
                                        ),
                                        id: id,
                                        icon: true,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.person,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ['firstName']
                                                        .toString(),
                                                    style: GoogleFonts.archivo(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .docs[index]['lastName']
                                                        .toString(),
                                                    style: GoogleFonts.archivo(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['birth']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.email_rounded,
                                          color:
                                              Color.fromARGB(174, 15, 14, 14),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['email']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.male,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.docs[index]['gender']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                Icons.phone,
                                                color: Color.fromARGB(
                                                    174, 15, 14, 14),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!
                                                  .docs[index]['phoneNumber']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  if (snapshot.data!.docs[index]['userNote'] !=
                                      null) ...[
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Visibility(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                240, 238, 227, 124),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Text(
                                              snapshot
                                                  .data!.docs[index]['userNote']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
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
                  });
            },
          ),
        )
      ]),
    );
  }
}
