import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/login.dart';
import 'package:crud/crud/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Image(image: AssetImage(ImageConstant.loginsignup),
                  height: height*0.468,
                  width: width*0.91,),
Column(
  children: [
    Text(
      "CRUD",
      style: TextStyle(
          fontSize: width*0.08,
        fontWeight:FontWeight.w900,
        color: ColorConstant.primeryColor,
      ),),
    Text("Create, Read, Update ,Delete",
      style: TextStyle(
          color: ColorConstant.primeryColor,
        fontWeight: FontWeight.w700,
        fontSize: width*0.04
      ),),
  ],
),
          SizedBox(height:height*0.05),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),),ModalRoute.withName("/"));


              },
              child: Container(
                height: height*0.075,
                width: width*0.708,
                decoration: BoxDecoration(
                   color: ColorConstant.primeryColor,
                  borderRadius: BorderRadius.circular(width*0.09),
                ),
                child: Center(child: Text("Login",
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: width*0.07
                ),
                )),
              ),
            ) ,
            SizedBox(height: height*0.03,),
            InkWell(

              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(email: '', name: '', uid: '',),));

              },
              child: Container(
                height: height*0.075,
                width: width*0.705,
                decoration: BoxDecoration(
                   color: ColorConstant.secondaryColor,
                  borderRadius: BorderRadius.circular(width*0.09),
                  border: Border.all(color: ColorConstant.primeryColor,width: width*0.005)
                ),
                child: Center(child: Text("Sign up",
                style: TextStyle(
                  color: ColorConstant.primeryColor,
                  fontSize: width*0.07,
                  fontWeight: FontWeight.w700
                ),
                )),
              ),
            )

          ],
        ),
      ),
    );
  }
}
