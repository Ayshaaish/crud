import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/firebaseconstant.dart';
import 'package:crud/firebase/gettaskk.dart';
import 'package:crud/modalclass.dart';
import 'package:crud/firebase/readtask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';
import '../main.dart';

class AddSetTaskPage1 extends StatefulWidget {
  const AddSetTaskPage1({super.key});

  @override
  State<AddSetTaskPage1> createState() => _AddSetTaskPage1State();
}

class _AddSetTaskPage1State extends State<AddSetTaskPage1> {
bool eye= false;
  TextEditingController passwordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
AddNdSet() async {
  QuerySnapshot querySnap = await FirebaseFirestore.instance
      .collection(FirebaseConstants.userss).get();

  if (querySnap.docs.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User with this name, email, or password already exists!")),
    );
  } else {
    TestModel test = TestModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      id: '',
    );

    FirebaseFirestore.instance.collection(FirebaseConstants.userss).add(test.toMap()).then((value) {
      value.update({'id': value.id});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User added successfully!")),
      );
    });
  }
}

  @override
  Widget build(BuildContext context) {
    height= MediaQuery.of(context).size.height;
    width= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: height*0.03,),
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,//button
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding:EdgeInsets.all(width*0.03),
                    child: SvgPicture.asset(SvgImageConstant.svguser),
                  ),
                  labelText: "Username",
                  labelStyle: TextStyle(
                      color: ColorConstant.thirdColor
                  ),
                  hintText: "please enter your name",
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                          color:ColorConstant.thirdColor
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                        color: ColorConstant.thirdColor
                    ),
                  )
              ),
            ),
            SizedBox(height: height*0.03,),
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
                  padding:EdgeInsets.all(width*0.03),
                  child: SvgPicture.asset(SvgImageConstant.svgmail),
                ),
                labelText: "email",
                labelStyle: TextStyle(
                    color: ColorConstant.thirdColor
                ),
                hintText: "please enter your email",
                enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstant.thirdColor
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width*0.03),
                  borderSide: BorderSide(
                    color: ColorConstant.thirdColor,
                  ),
                ),

              ),
            ),
            SizedBox(height: height*0.03,),
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
                      eye=!eye;
                      setState(() {

                      });
                    },
                    child:Padding(
                      padding:EdgeInsets.all(width*0.03),
                      child: SvgPicture.asset(eye?SvgImageConstant.svgpasslock:SvgImageConstant.svgopenlock),
                    )),
                labelStyle: TextStyle(
                    color: ColorConstant.thirdColor
                ),
                hintText: "enter passward",
                enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstant.thirdColor
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width*0.03),
                  borderSide: BorderSide(
                    color: ColorConstant.thirdColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.03,
                    width: width*0.03,),
            ElevatedButton(

                onPressed: () {
                  AddNdSet();
                  Navigator.pop(context);
    },
                child: Center(child: Text("Add"))
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crud/firebase/readtask.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../constant/color_constant.dart';
// import '../constant/image_contant.dart';
//
// class AddSetTaskPage1 extends StatefulWidget {
//   const AddSetTaskPage1({super.key});
//
//   @override
//   State<AddSetTaskPage1> createState() => _AddSetTaskPage1State();
// }
//
// class _AddSetTaskPage1State extends State<AddSetTaskPage1> {
//   bool eye = false;
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//
//   // Function to check if the user exists and add if not
//   Future<void> checkAndAddUser() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('userss')
//         .where(Filter.or(
//       Filter('name', isEqualTo: nameController.text),
//       Filter('email', isEqualTo: emailController.text),
//       Filter('password', isEqualTo: passwordController.text),
//     ))
//         .get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       // User already exists
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User with this name, email, or password already exists!')),
//       );
//     } else {
//       // Add user to Firestore
//       DocumentReference newUserRef =
//       await FirebaseFirestore.instance.collection('userss').add({
//         'name': nameController.text,
//         'email': emailController.text,
//         'password': passwordController.text,
//       });
//
//       // Update the document with the generated ID
//       await newUserRef.update({'id': newUserRef.id});
//
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User added successfully!')),
//       );
//
//       // Navigate to the ReadTask page
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ReadTask(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(height: height * 0.03),
//             TextFormField(
//               controller: nameController,
//               textCapitalization: TextCapitalization.words,
//               textInputAction: TextInputAction.next,
//               decoration: InputDecoration(
//                 suffixIcon: Padding(
//                   padding: EdgeInsets.all(width * 0.03),
//                   child: SvgPicture.asset(SvgImageConstant.svguser),
//                 ),
//                 labelText: "Username",
//                 labelStyle: TextStyle(color: ColorConstant.thirdColor),
//                 hintText: "Please enter your name",
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: ColorConstant.thirdColor)),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(width * 0.03),
//                   borderSide: BorderSide(color: ColorConstant.thirdColor),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             TextFormField(
//               controller: emailController,
//               textInputAction: TextInputAction.next,
//               decoration: InputDecoration(
//                 suffixIcon: Padding(
//                   padding: EdgeInsets.all(width * 0.03),
//                   child: SvgPicture.asset(SvgImageConstant.svgmail),
//                 ),
//                 labelText: "Email",
//                 labelStyle: TextStyle(color: ColorConstant.thirdColor),
//                 hintText: "Please enter your email",
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: ColorConstant.thirdColor)),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(width * 0.03),
//                   borderSide: BorderSide(color: ColorConstant.thirdColor),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             TextFormField(
//               obscureText: eye,
//               controller: passwordController,
//               textInputAction: TextInputAction.done,
//               decoration: InputDecoration(
//                 labelText: "Password",
//                 suffixIcon: InkWell(
//                   onTap: () {
//                     setState(() {
//                       eye = !eye;
//                     });
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.all(width * 0.03),
//                     child: SvgPicture.asset(
//                         eye ? SvgImageConstant.svgpasslock : SvgImageConstant.svgopenlock),
//                   ),
//                 ),
//                 labelStyle: TextStyle(color: ColorConstant.thirdColor),
//                 hintText: "Enter password",
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: ColorConstant.thirdColor)),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(width * 0.03),
//                   borderSide: BorderSide(color: ColorConstant.thirdColor),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.05),
//             ElevatedButton(
//               onPressed: checkAndAddUser,
//               child: Center(child: Text("Add")),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
