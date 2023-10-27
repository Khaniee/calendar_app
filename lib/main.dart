import 'package:flutter/material.dart';
import 'package:my_project/bottom_navbar_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calendar App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const BottomNavBarPages());
  }
}
