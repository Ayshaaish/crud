import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/firebase/storage/adduser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../../modalclass.dart';


class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool eye = false;
  bool eye2 = false;
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
    uploadFile(file);
    Navigator.pop(context);
  }

  String imgUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqafzhnwwYzuOTjTlaYMeQ7hxQLy_Wq8dnQg&s';
  uploadFile(File file) async {
    String ext = file.path.split('_').last;
    var uploadTask = await FirebaseStorage.instance
        .ref('uploads')
        .child(DateTime.now().toString())
        .putFile(file, SettableMetadata(contentType: 'image/$ext'));
    var getUrl = await uploadTask.ref.getDownloadURL();
    imgUrl = getUrl;
    setState(() {});
  }

  /// search
  generateSearchKey(String name) {
    List<String> searchKeys = [];
    String lowerName = name.toLowerCase();

    List<String> nameParts = lowerName.split(' ');
    for (String part in nameParts) {
      for (int i = 1; i <= part.length; i++) {
        searchKeys.add(part.substring(0, i));
      }
    }
    for (int i = 1; i <= lowerName.length; i++) {
      searchKeys.add(lowerName.substring(0, i));
    }
    return searchKeys.toSet().toList();
  }

  ///add
  addUserFunction() async {
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('adds')
        .where("email", isEqualTo: emailController.text)
        .get();

    if (querySnap.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User with this email already exists!")),
      );
    } else {
      List<String> searchKeyList = generateSearchKey(nameController.text);

      AddUserModel user = AddUserModel(
        email: emailController.text,
        password: passwordController.text,
        username: nameController.text,
        confirmpassword: confirmpasswordController.text,
        id: '',
        image: imgUrl,
      );
      FirebaseFirestore.instance
          .collection('adds')
          .add(user.toMap())
          .then((value) {
        value.update({'id': value.id});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User added successfully!")),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add user: $error")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add User",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: width * 0.05,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.06),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: width * 0.2,
                  backgroundImage: NetworkImage(imgUrl),
                  backgroundColor: Colors.red,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: width * 0.05,
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
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddUser(),
                                              ));
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        )),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.edit)),
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
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "please enter your name",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      borderSide: BorderSide(color: Colors.black),
                    )),
              ),
              SizedBox(
                height: height * 0.03,
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
                  labelText: "email",
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: "please enter your email",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
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
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: "enter passward",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              TextFormField(
                obscureText: eye2,
                // validator: (value) {
                //   if(!passwordValidation.hasMatch(value!)){
                //     return"enter your password";
                //   }else{
                //     return null ;
                //   }
                // },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: confirmpasswordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Confirm Passward",
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: "enter passward",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.07,
              ),
              InkWell(
                onTap: () {
                  addUserFunction();
                  Navigator.pop(context);
                },
                child: Container(
                  height: height * 0.065,
                  width: width * 0.705,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.09),
                      border: Border.all(
                          color: Colors.black, width: width * 0.005)),
                  child: Center(
                      child: Text(
                        "Add User",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
