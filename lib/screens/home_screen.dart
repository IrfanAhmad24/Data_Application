import 'package:flutter/material.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:flutter_practice_application/screens/user_details_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> userDetailList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'User List',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: userDetailList.length,
        itemBuilder: (context, index) {
          User user = userDetailList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                '${user.firstName} ${user.lastName}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user.email}'),
                  Text('Phone: ${user.phoneNumber}'),
                  Text('User Note: ${user.userNote}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          // Navigate to UserDetails and wait for result
          final newUser = await Navigator.push<User>(
            context,
            MaterialPageRoute(builder: (context) => const UserDetails()),
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
}
