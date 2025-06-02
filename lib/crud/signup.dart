import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/firebaseconstant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/constant/messengerconstant.dart';
import 'package:crud/crud/login.dart';
import 'package:crud/crud/login_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';
import 'homepage1.dart';

class SignUp extends StatefulWidget {
  final String? email;
  final String? name;
  final String uid;

  const SignUp({super.key, required this.email, required this.name, required this.uid});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool eye = false;
  bool lock = false;
  // final passwordValidation =
  // RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
  // final emailValidation = RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  var file;
  pickFile(ImageSource) async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      file = File(imageFile.path);
      setState(() {});
    }
  }
///old
  // creatUser() async {
  //   await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //           email: emailController.text, password: passwordController.text)
  //       .then(
  //     (value) async {
  //       final uid=value.user?.uid??'';
  //     await  FirebaseFirestore.instance
  //           .collection("login_users")
  //           .doc(value.user!.uid)
  //           .set({
  //         "username":nameController.text,
  //         "email":emailController.text,
  //         "password":passwordController.text,
  //         "confirmpassword":confirmpasswordController.text,
  //       'id':uid,
  //       "favorite":[]
  //       }).then((value) =>Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),)),);
  //     },
  //   );
  // }
  /// otherone
  // userSignup() {
  //   if (emailController.text == "") {
  //     showUploadMessage('enter email', context);
  //   }
  //   if (passwordController.text == "") {
  //   showUploadMessage('enter password', context);
  //   }
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //       email: emailController.text, password: passwordController.text)
  //       .then(
  //         (value) {
  //       String id = value.user?.uid ?? "";
  //       Map<String, dynamic> text = {
  //         "name": nameController.text,
  //         "email": emailController.text,
  //         "password":passwordController.text,
  //         "confirm":confirmpasswordController.text,
  //         "id": id,
  //       };
  //       FirebaseFirestore.instance
  //           .collection("login_users")
  //           .doc(id)
  //           .set(text)
  //           .then(
  //             (value) {
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             CupertinoPageRoute(
  //               builder: (context) => HomePage1(),
  //             ),
  //                 (route) => false,
  //           );
  //         },
  //       );
  //     },
  //   );
  // }\

  creatUser() async {
    try {

      if (widget.uid.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("login_users")
            .doc(widget.uid)
            .set({
          "username": nameController.text,
          "email": emailController.text,
          "favorite": [],
          "createdAt": DateTime.now(),
          "id": widget.uid,
          "password": passwordController.text,
          "confirmpassword": confirmpasswordController.text,

        });


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage1(
              userId: widget.uid,
              userName: nameController.text,
            ),
          ),
        );
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
            .then((value) async {
          final uid = value.user?.uid ?? '';
          await FirebaseFirestore.instance
              .collection("login_users")
              .doc(uid)
              .set({
            "username": nameController.text,
            "email": emailController.text,
            "password": passwordController.text,
            "confirmpassword": confirmpasswordController.text,
            "id": uid,
            "favorite": [],
            "createdAt": DateTime.now(),
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      }
    } catch (e) {
      print("Sign Up Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.email != null) {
      emailController.text = widget.email!;
    }
    if (widget.name != null) {
      nameController.text = widget.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                  context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),
        title: Text(
          "User Registration",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: width * 0.05,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.06),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: width * 0.18,
                  backgroundImage: file != null
                      ? FileImage(file)
                      : AssetImage(ImageConstant.profile),
                  backgroundColor: ColorConstant.thirdColor,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                    onPressed: () {
                                      pickFile(ImageSource.gallery);
                                    },
                                    child: Text("Photo Gallery")),
                                CupertinoActionSheetAction(
                                    onPressed: () {
                                      pickFile(ImageSource.camera);
                                    },
                                    child: Text("Camera")),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(
                                        context,);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.fifthColor,
                                    ),
                                  )),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: width * 0.05,
                        child: SvgPicture.asset(
                          SvgImageConstant.svgpencil,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
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
              TextFormField(
                obscureText: lock,
                controller: confirmpasswordController,
                textCapitalization: TextCapitalization.words, //button
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,

                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(width * 0.03),
                      child: InkWell(
                          onTap: () {
                            lock = !lock;
                            setState(() {});
                          },
                          child: SvgPicture.asset(lock
                              ? SvgImageConstant.svgpasslock
                              : SvgImageConstant.svgopenlock)),
                    ),
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: ColorConstant.thirdColor),
                    hintText: "please enter your name",
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorConstant.thirdColor)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      borderSide: BorderSide(color: ColorConstant.thirdColor),
                    )),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              InkWell(
                onTap: () {
                  creatUser();
                  },
                child: Container(
                  height: height * 0.065,
                  width: width * 0.705,
                  decoration: BoxDecoration(
                      color: ColorConstant.secondaryColor,
                      borderRadius: BorderRadius.circular(width * 0.09),
                      border: Border.all(
                          color: ColorConstant.primeryColor,
                          width: width * 0.005)),
                  child: Center(
                      child: Text(
                    "Sign up",
                    style: TextStyle(
                        color: ColorConstant.primeryColor,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
              SizedBox(
                height: height * 0.12,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: Text(
                  "Already have an Account Login ?",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
