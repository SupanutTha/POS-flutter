// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hotel_pos/screen/add_room_screen.dart';
import 'package:hotel_pos/screen/all_room.dart';
import '../style/app_style.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(title: const Text("AppBar"), actions: []),
      //body
      body: Container(
        child: Column(children: [
          Center(
              child: Text(
            "Welcome",
            style: AppTextStyles.welcomeText,
          )),
          OutlinedButton( 
            style: AppButtonStyles.outlinedButtonStyle,
            child: const Text('All room',style: AppTextStyles.welcomeText,),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AllRoom()),
            );
            },
          ),
          OutlinedButton(
            style: AppButtonStyles.outlinedButtonStyle,
            child: const Text('add room',style: AppTextStyles.welcomeText,),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddRoom()),
            );
            },
          ),
          OutlinedButton(
            style: AppButtonStyles.outlinedButtonStyle,
            child: const Text('edit room',style: AppTextStyles.welcomeText,),
            onPressed: () {},
          )
        ]),
      ),
      //Bottom Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: null,
      ),
    );
  } //ef
}//ec