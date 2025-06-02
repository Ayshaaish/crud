import 'package:crud/main.dart';
import 'package:crud/firebase/sharedpreference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  ///user
  // getUserName() async {
  //   SharedPreferences prefs=await SharedPreferences.getInstance();
  //   currentUserName=prefs.getString('username')??'';
  //   setState(() {
  //   });
  // }
  // @override
  // void initState() {
  //   getUserName();
  //  super.initState();
  // }
  // removeUserName() async {
  //   SharedPreferences prefs=await SharedPreferences.getInstance();
  //   prefs.remove('username');
  //   prefs.clear();
  // }

  ///number
  getUserNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserNumber = prefs.getInt('usernumber') ?? 0;
    setState(() {

    });
  }

  @override
  void initState() {
    getUserNumber();
    super.initState();
  }

  removeUserNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('number');
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("homepage"),
        centerTitle: true,
        backgroundColor: Colors.white,
        // actions: [
        //   InkWell(
        //     onTap: () {
        // removeUserName();
        //       Navigator.pushReplacement(context, MaterialPageRoute(
        //         builder: (context) =>SharedPreference (),));
        //     },
        //       child: Icon(Icons.add))
        // ],
      ),
      body: Column(
        children: [
          // Center(
          //   child: Text("hellow,$currentUserName"),
          // ),
          Center(
            child: Text("phone number$currentUserNumber"),
          ),
        ],
      ),
    );
  }
}
