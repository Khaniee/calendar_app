import 'package:flutter/material.dart';
import 'package:my_project/bottom_navbar_pages.dart';
import 'package:my_project/providers/event_provider.dart';
import 'package:my_project/providers/task_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calendar App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const BottomNavBarPages(),
      ),
    );
  }
}
