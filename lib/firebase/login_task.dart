import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/firebase/agepagetask.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import '../constant/messengerconstant.dart';
import '../main.dart';

class LoginNewTask extends StatefulWidget {
  const LoginNewTask({super.key});

  @override
  State<LoginNewTask> createState() => _LoginNewTaskState();
}

class _LoginNewTaskState extends State<LoginNewTask> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool eye = false;

   loginWithgetMethod() async {
    if (nameController.text.isEmpty) {
      showUploadMessage('Please enter username', context);
      return;
    }
    if (emailController.text.isEmpty) {
      showUploadMessage('Please enter email', context);
      return;
    }
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('Students')
        .where('name', isEqualTo: nameController.text).where('email', isEqualTo: emailController.text)
        .get();
     if(emailController.text.isNotEmpty && nameController.text.isNotEmpty){
       Map<String,dynamic> userData=data.docs[0].data() as Map<String,dynamic>;

       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => AgeTask(userData: userData,)),
       );
     }
    if (data.docs.isEmpty) {
      showUploadMessage('User does not exist', context);
      return;
    } else {
      if (data.docs[0]['email'] == emailController.text) {

      } else {
        showUploadMessage('Wrong email', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: const TextStyle(color: Colors.black),
                hintText: "Please enter your name",
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  borderSide: BorderSide(
                    color: ColorConstant.thirdColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            TextFormField(
              obscureText: eye,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "email",
                labelStyle: const TextStyle(color: Colors.black),
                hintText: "Enter email",
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
            SizedBox(height: height * 0.02),
            Center(
              child: ElevatedButton(
                onPressed: () {

                  loginWithgetMethod();
                },
                child: const Text('Login'),
              ),
            ),
            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}

