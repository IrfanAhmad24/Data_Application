import 'package:flutter/material.dart';
import 'package:flutter_practice_application/screens/user_data.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserDetails()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
