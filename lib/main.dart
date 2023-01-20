import 'package:flutter/material.dart';
import 'package:userprof_ui/user_profile.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'User Profile',
    theme: ThemeData(
        primaryColor: Colors.cyan
    ),
    home: const UserProfile(),
  ));
}