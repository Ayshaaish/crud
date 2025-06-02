import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import '../main.dart';

class LoginToDo extends StatefulWidget {
  const LoginToDo({super.key});

  @override
  State<LoginToDo> createState() => _LoginToDoState();
}
TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
bool eye = false;
class _LoginToDoState extends State<LoginToDo> {
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
