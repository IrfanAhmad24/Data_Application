import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:flutter_practice_application/responsives/mobilr_user.dart';
import 'package:flutter_practice_application/responsives/web_user.dart';

class Mobile_Home extends StatefulWidget {
  const Mobile_Home({super.key});

  @override
  State<Mobile_Home> createState() => _Mobile_HomeState();
}

List<User> userDetailList = [];
bool isVisible = false;

class _Mobile_HomeState extends State<Mobile_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff31363F),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Color(0xff76ABAE),
            title: Text(
              'User Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            foregroundColor: Colors.white,
          ),
        ],
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!isVisible)
                setState(
                  () => isVisible = true,
                );
            } else if (notification.direction == ScrollDirection.reverse) {
              if (isVisible)
                setState(
                  () => isVisible = false,
                );
            }
            return true;
          },
          child: ListView.builder(
              itemCount: userDetailList.length,
              itemBuilder: (context, index) {
                User user = userDetailList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xff76ABAE),
                        )),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _deleteUser(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MobileUserDetailsPage(user: user),
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
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Email: ${user.email}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Gender: ${user.gender}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Phone: ${user.phoneNumber}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Birth: ${dateController.text}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            'Note:${user.userNote}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff76ABAE),
          onPressed: () async {
            // Navigate to UserDetails and wait for result
            final newUser = await Navigator.push<User>(
              context,
              MaterialPageRoute(builder: (context) => MobileUserDetailsPage()),
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
      ),
    );
  }

  void _deleteUser(int index) {
    setState(() {
      userDetailList.removeAt(index); // Remove user at specific index
    });
  }
}
