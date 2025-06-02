import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/firebaseconstant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/constant/messengerconstant.dart';
import 'package:crud/crud/homepage1.dart';
import 'package:crud/crud/phone.dart';
import 'package:crud/crud/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool eye = false;

  // final passwordValidation =
  // RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

// setUserName() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('username', nameController.text) ?? '';
//   Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HomePage1(),
//       ));
// }

// loginWithgetMethod() async {
//     if(nameController.text==''){
//       showUploadMessage('please enter username', context);
//     }if(passwordController.text=='') {
//       showUploadMessage('please enter password', context);
//     }
//     QuerySnapshot data= await FirebaseFirestore.instance.
//     collection(FirebaseConstants.users).where('username',isEqualTo: nameController.text).get();
//     if(data.docs.isEmpty){
//       showUploadMessage('user does not exist', context);
//     }else{
//       if(data.docs[0]['password']==passwordController.text){
//         Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage1(),));
//       }else{
//         showUploadMessage('wrongPassword', context);
//       }
//     }
// }


signInWithEmailAndPassword() async {
  try {
    final UserCredential auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: nameController.text, password: passwordController.text);
    if (auth.user != null) {
      final String id = auth.user?.uid ?? '';
      // DocumentSnapshot user = await FirebaseFirestore.instance
      //     .collection("login_users")
      //     .doc(auth.user!.uid)
      //     .get();
      // if (user.exists) {
      //   String name = user['name'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', id);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomePage1(userId: id, userName: '',),),
          ModalRoute.withName("/"));
    }
  }
  // }
  on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-credential') {
      print("usernot found");
      showUploadMessage('user not found', context);
    }
    if (e.code == 'wrong-password') {
      showUploadMessage('wrong password', context);
    }
  }
  catch (e) {

  }
  // .then(
  //   (value) => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => HomePage1(),
  //       )),);
}
/// not adding any details to firebase
// signInWithGoogle() async {
//   try {
//     await GoogleSignIn().signOut();
//
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return null;
//
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     final UserCredential userCredential =
//     await FirebaseAuth.instance.signInWithCredential(credential);
//
//     final User? user = userCredential.user;
//     if (user != null) {
//       String userName = googleUser.displayName ?? 'User'; // Fallback if displayName is null
//            print(userName);
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage1(userId: user.uid,userName: userName,),
//         ),
//       );
//     }
//
//     return userCredential;
//   } catch (e) {
//     print("Google Sign-In Error: $e");
//     return null;
//   }
// }

  signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final email = user.email ?? "";
        final name = googleUser.displayName ?? "";
        final uid = user.uid;

        final docSnapshot = await FirebaseFirestore.instance
            .collection("login_users")
            .doc(uid)
            .get();

        if (docSnapshot.exists) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage1(userId: uid, userName: name),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUp(
                email: email,
                name: name,
                uid: uid,
              ),
            ),
          );
        }
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //   onTap: () {
        //         Navigator.pop(context, MaterialPageRoute(builder: (context) => Login(),));
        //   },
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
        //     )),
        backgroundColor: ColorConstant.secondaryColor,
        title: Text(
          "CRUD",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: width * 0.05,
            color: ColorConstant.thirdColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(ImageConstant.login),
                height: height * 0.3,
                width: width * 0.9,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    //button
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "please enter your name",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
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
                                ? SvgImageConstant.svgeye
                                : SvgImageConstant.svgeyeclose),
                          )),
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "enter passward",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: ColorConstant.thirdColor)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        borderSide: BorderSide(
                          color: ColorConstant.thirdColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.027),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      signInWithEmailAndPassword();
                      // setUserName();
                      // loginWithgetMethod();
                    },
                    child: Container(
                      height: height * 0.070,
                      width: width * 0.708,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.09),
                          border: Border.all(
                              color: ColorConstant.primeryColor,
                              width: width * 0.005)),
                      child: ListTile(
                        leading: SvgPicture.asset(SvgImageConstant.svglock),
                        title: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.primeryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InkWell(
                    onTap: () {

                      signInWithGoogle();
                    },
                    child: Container(
                      height: height * 0.070,
                      width: width * 0.708,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.09),
                          border: Border.all(
                              color: ColorConstant.primeryColor,
                              width: width * 0.005)),
                      child: ListTile(
                        leading: SvgPicture.asset(SvgImageConstant.svggoogle),
                        title: Center(
                            child: Text(
                              "Sign in with Google",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.primeryColor,
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhonePage(),
                          ));
                    },
                    child: Container(
                      height: height * 0.070,
                      width: width * 0.708,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.09),
                          border: Border.all(
                              color: ColorConstant.primeryColor,
                              width: width * 0.005)),
                      child: ListTile(
                        leading: SvgPicture.asset(SvgImageConstant.svgcall),
                        title: Center(
                            child: Text(
                              "OTP sign in",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.primeryColor,
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(email: '', name: '', uid: '',),
                          ));
                    },
                    child: Text(
                      "Don't have an account ? Create now ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.primeryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
