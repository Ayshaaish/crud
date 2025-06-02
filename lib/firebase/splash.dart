import 'package:crud/constant/color_constant.dart';
import 'package:crud/crud/login_signup.dart';
import 'package:crud/firebase/sharedpreference.dart';
import 'package:crud/firebase/sharedpreference2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
///username
//   getUserName() async {
//     SharedPreferences prefs=await SharedPreferences.getInstance();
//     currentUserName=prefs.getString('username')??'';
//
//     setState(() {
//     });
//   }
  getUserNumber() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    currentUserNumber=prefs.getInt('usernumber')??0;
    setState(() {

    });
  }
  @override
  void initState() {
    // getUserName();
    getUserNumber();
    Future.delayed(
        Duration(seconds: 3)).then((value) =>   Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) =>SharedPreference ())),);
    super.initState();
  }

  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstant.primeryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("CRUD",
              style:TextStyle(
                  fontSize: width*0.08,
                  fontWeight: FontWeight.w900,
                  color: ColorConstant.secondaryColor
              ) ,
            ),
          ],
        ),
      ),
    );

  }
}

