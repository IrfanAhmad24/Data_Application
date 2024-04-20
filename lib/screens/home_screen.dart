import 'package:flutter/material.dart';
import 'package:flutter_practice_application/models/user_details_model.dart';
import 'package:flutter_practice_application/screens/user_data.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'User Data',
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<UserDetailsModel>(
        builder: (context, userDetailsModel, _) {
          if (userDetailsModel.userDetailList.isEmpty) {
            return const Center(
              child: Text('No user details added yet'),
            );
          } else {
            return ListView.builder(
              itemCount: userDetailsModel.userDetailList.length,
              itemBuilder: (context, index) {
                Map<String, String> userDetails =
                    userDetailsModel.userDetailList[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      'Name: ${userDetails['firstName']} ${userDetails['lastName']}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // icon to remove card
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  userDetailsModel.removeUserDetail(index);
                                },
                                child: Icon(Icons.delete))
                          ],
                        ),
                        Text(
                          'Email: ${userDetails['email']}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Phone Number: ${userDetails['phoneNumber']}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Note: ${userDetails['userNote']}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserDetails()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
