import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_application/responsives/mobile_body.dart';
import 'package:flutter_practice_application/responsives/web_body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    // Determine which page to display based on screen width
    Widget pageToDisplay = currentWidth < 600 ? Mobile_Home() : MyWebBody();

    return Scaffold(
      body: pageToDisplay,
    );
  }
}
