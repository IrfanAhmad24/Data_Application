import 'package:flutter/material.dart';
import 'package:flutter_practice_application/models/user_details_model.dart';
import 'package:flutter_practice_application/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserDetailsModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Home(),
      ),
    );
  }
}
