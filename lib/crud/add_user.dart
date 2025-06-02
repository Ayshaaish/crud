import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/homepage2.dart';
import 'package:crud/crud/signup.dart';
import 'package:crud/constant/firebaseconstant.dart';
import 'package:crud/modalclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool eye=false;
  bool eye2=false;
  // final passwordValidation =
  // RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
  // final emailValidation = RegExp(
  //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController passwordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController confirmpasswordController=TextEditingController();
  var file;
  pickFile(ImageSource) async {
    final imageFile=await ImagePicker().pickImage(source: ImageSource);
    file=File(imageFile!.path);
    if(mounted){
      file=File(imageFile.path);
      setState(() {

      });
    }
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
        .collection(FirebaseConstants.users)
        .where("email", isEqualTo: emailController.text)
        .get();

    if (querySnap.docs.isNotEmpty) {
      // User already exists
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User with this email already exists!")),
      );
    } else {
      List<String> searchKeyList = generateSearchKey(nameController.text);

      UserModel user = UserModel(
        email: emailController.text,
        password: passwordController.text,
        username: nameController.text,
        confirmpassword: confirmpasswordController.text,
        id: '',
        searchkey: searchKeyList,
      );

      FirebaseFirestore.instance
          .collection(FirebaseConstants.users)
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
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:EdgeInsets.all(width*0.03),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),
        title:Text("Add User",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: width*0.05,
          ),),
        centerTitle: true,
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(width*0.06),
        child: SingleChildScrollView(
          child: Column(
            children: [
              file!=null? CircleAvatar(
                radius: width*0.2,
                   backgroundImage: FileImage(file),
            backgroundColor: ColorConstant.thirdColor,
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
          
                },
                child: CircleAvatar(
                  radius: width*0.05,
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
                                    child: Text("Photo Gallery")
                                ),
                                CupertinoActionSheetAction(
                                    onPressed: () {
                                      pickFile(ImageSource.camera);
                                    },
                                    child: Text("Camera")
                                ),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context, MaterialPageRoute(builder: (context) => AddUser(),));
                                  },
                                  child: Text("Cancel",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.fifthColor,
                                    ),)
                              ),
                            );
                          },
                        );
          
                      },
                      child: SvgPicture.asset(SvgImageConstant.svgpencil,fit: BoxFit.fill,)) ,
                ),
              ),
            ),
                ):
              Center(
                child: CircleAvatar(
                  radius: width*0.2,
                  backgroundImage: AssetImage(ImageConstant.profile),
                  backgroundColor: ColorConstant.thirdColor,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
          
                      },
                      child: CircleAvatar(
                        radius: width*0.05,
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
                                          child: Text("Photo Gallery")
                                      ),
                                      CupertinoActionSheetAction(
                                          onPressed: () {
                                            pickFile(ImageSource.camera);
                                          },
                                          child: Text("Camera")
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context, MaterialPageRoute(builder: (context) => AddUser(),));
                                        },
                                        child: Text("Cancel",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.fifthColor,
                                          ),)
                                    ),
                                  );
                                },
                              );
          
                            },
                            child: SvgPicture.asset(SvgImageConstant.svgpencil,fit: BoxFit.fill,)) ,
                      ),
                    ),
                  ),
          
                ),
              ),
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
              SizedBox(height: height*0.03,),

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
                  suffixIcon: InkWell(
                      onTap: () {
                        eye2=!eye2;
                        setState(() {

                        });
                      },
                      child:Padding(
                        padding:EdgeInsets.all(width*0.03),
                        child: SvgPicture.asset(eye2?SvgImageConstant.svgpasslock:SvgImageConstant.svgopenlock),
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
              SizedBox(height: height*0.07,),
              InkWell(
          
                onTap: () {
                  addUserFunction();
                  Navigator.pop(context);
                },
                child: Container(
                  height: height*0.065,
                  width: width*0.705,
                  decoration: BoxDecoration(
                      color: ColorConstant.secondaryColor,
                      borderRadius: BorderRadius.circular(width*0.09),
                      border: Border.all(color: ColorConstant.primeryColor,width: width*0.005)
                  ),
                  child: Center(child: Text("Add User",
                    style: TextStyle(
                        color: ColorConstant.primeryColor,
                        fontSize: width*0.05,
                        fontWeight: FontWeight.w700
                    ),
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
