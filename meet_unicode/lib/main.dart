import 'package:flutter/material.dart';
import 'package:meet_unicode/constants/colors.dart';
import 'package:meet_unicode/screens/profilepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meet Unicode Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
          fontFamily: "Nunito"),
      home: const ProfilePage(),
    );
  }
}
