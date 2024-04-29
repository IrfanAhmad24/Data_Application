import 'package:flutter/material.dart';

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
  List<User> userDetailList = [];

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
            MaterialPageRoute(builder: (context) => const UserDetailsPage()),
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
      body: ListView.builder(
          itemCount: userDetailList.length,
          itemBuilder: (context, index) {
            User user = userDetailList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(
                        user: user,
                        showDeleteIcon: true,
                      ),
                    ),
                  ).then((updatedUser) {
                    if (updatedUser != null) {
                      // Update userDetailList with the updated user
                      setState(() {
                        userDetailList[index] = updatedUser;
                      });
                    }
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                        )),
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.person,
                                        color: Color.fromARGB(174, 15, 14, 14),
                                      ),
                                    ),
                                    Text('${user.firstName} ${user.lastName}',
                                        style: GoogleFonts.archivo(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              Text(
                                '${dateController.text}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (user.userNote != null &&
                              user.userNote!.isNotEmpty) ...[
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Visibility(
                                visible: user.userNote != null &&
                                    user.userNote!.isNotEmpty,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        240, 238, 227, 124),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    child: Text(
                                      '${user.userNote}',
                                      style:
                                          const TextStyle(color: Colors.white),
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
          }),
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
        centerTitle: false,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: userDetailList.length,
        itemBuilder: (context, index) {
          User user = userDetailList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(
                    user: user,
                    showDeleteIcon: true,
                  ),
                ),
              ).then((updatedUser) {
                if (updatedUser != null) {
                  // Update userDetailList with the updated user
                  setState(() {
                    userDetailList[index] = updatedUser;
                  });
                }
              });
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
                    )),
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
                          Container(
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.person,
                                    color: Color.fromARGB(174, 15, 14, 14),
                                  ),
                                ),
                                Text('${user.firstName} ${user.lastName}',
                                    style: GoogleFonts.archivo(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                          Text(
                            '${dateController.text}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
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
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
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
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (user.userNote != null &&
                          user.userNote!.isNotEmpty) ...[
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Visibility(
                            visible: user.userNote != null &&
                                user.userNote!.isNotEmpty,
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
          );
        },
      ),
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
        centerTitle: false,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: userDetailList.length,
        itemBuilder: (context, index) {
          User user = userDetailList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(user: user),
                ),
              ).then((updatedUser) {
                if (updatedUser != null) {
                  // Update userDetailList with the updated user
                  setState(() {
                    userDetailList[index] = updatedUser;
                  });
                }
              });
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
                    )),
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
                          Container(
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.person,
                                    color: Color.fromARGB(174, 15, 14, 14),
                                  ),
                                ),
                                Text('${user.firstName} ${user.lastName}',
                                    style: GoogleFonts.archivo(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                          Text(
                            '${dateController.text}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
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
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
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
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (user.userNote != null &&
                          user.userNote!.isNotEmpty) ...[
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Visibility(
                            visible: user.userNote != null &&
                                user.userNote!.isNotEmpty,
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
          );
        },
      ),
    );
  }
}
