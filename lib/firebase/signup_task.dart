import 'package:crud/firebase/login_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';
import '../main.dart';

class SignupTask extends StatefulWidget {
  const SignupTask({super.key});

  @override
  State<SignupTask> createState() => _SignupTaskState();
}

class _SignupTaskState extends State<SignupTask> {
  bool eye = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registeration'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words, //button
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(width * 0.03),
                    child: SvgPicture.asset(SvgImageConstant.svguser),
                  ),
                  labelText: "Username",
                  labelStyle: TextStyle(color: ColorConstant.thirdColor),
                  hintText: "please enter your name",
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorConstant.thirdColor)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide(
                      color: ColorConstant.thirdColor,
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              // validator: (value) {
              //   if(!emailValidation.hasMatch(value!)){
              //     return"enter your email";
              //   }else{
              //     return null ;
              //   }
              // },
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.all(width * 0.03),
                  child: SvgPicture.asset(SvgImageConstant.svgmail),
                ),
                labelText: "email",
                labelStyle: TextStyle(color: ColorConstant.thirdColor),
                hintText: "please enter your email",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstant.thirdColor)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  borderSide: BorderSide(
                    color: ColorConstant.thirdColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              obscureText: eye,
              // validator: (value) {
              //   if(!passwordValidation.hasMatch(value!)){
              //     return"enter your password";
              //   }else{
              //     return null ;
              //   }
              // },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "passward",
                suffixIcon: InkWell(
                    onTap: () {
                      eye = !eye;
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.03),
                      child: SvgPicture.asset(eye
                          ? SvgImageConstant.svgpasslock
                          : SvgImageConstant.svgopenlock),
                    )),
                labelStyle: TextStyle(color: ColorConstant.thirdColor),
                hintText: "enter passward",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstant.thirdColor)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  borderSide: BorderSide(
                    color: ColorConstant.thirdColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: ElevatedButton(onPressed: () {
                Navigator.pop(context,MaterialPageRoute(builder: (context) =>LoginNewTask() ,));
              }
                  , child:Text('SignUp')
              ),
            )
          ],
        ),
      ),
    );
  }
}
