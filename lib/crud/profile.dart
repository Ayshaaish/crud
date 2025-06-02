import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/crud/homepage1.dart';
import 'package:crud/main.dart';
import 'package:crud/modalclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';

class Profile extends StatefulWidget {
final UserModel? user;
  const Profile({super.key,this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool eye=false;
  // final passwordValidation =
  // RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
  TextEditingController passwordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
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
  @override
  void initState() {
   nameController.text=widget.user!.username;
   passwordController.text=widget.user!.password;
   emailController.text=widget.user!.email;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.secondaryColor,
        leading: InkWell(
            onTap: () {
                  Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),

        title:Text("Profile",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: width*0.05,
          ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
          child: CircleAvatar(
          radius: width*0.2,
            backgroundImage:file!=null?FileImage(file):AssetImage(ImageConstant.profile),
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
                                Navigator.pop(context);
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
                child: CircleAvatar(
                  radius: width*0.05,
                  child: SvgPicture.asset(SvgImageConstant.svgpencil,fit: BoxFit.fill,) ,
                ),
              ),
            ),
          ),
                ),
              SizedBox(height: height*0.09,),
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,//button
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
          
                decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(
                        color: ColorConstant.primeryColor
                    ),
                    hintText: "please enter your name",
                    enabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstant.primeryColor
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(
                        color: ColorConstant.primeryColor,
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
                enabled: false,
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "email",
                  labelStyle: TextStyle(
                      color: ColorConstant.primeryColor
                  ),
                  hintText: "please enter your email",
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.primeryColor
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: ColorConstant.primeryColor,
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
                enabled: false,
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
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(eye?SvgImageConstant.svgeye:SvgImageConstant.svgeyeclose),
                      )),
                  labelStyle: TextStyle(
                      color: ColorConstant.primeryColor
                  ),
                  hintText: "enter passward",
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.primeryColor
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: ColorConstant.primeryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.09,),
              InkWell(
                onTap: () {
                  showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        actions: [
                          CupertinoDialogAction(
                              child: Text("Are you Sure You Want to Update Details?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.thirdColor,
          
                                ),)),
                          CupertinoDialogAction(
                              child: Text("Confirm",
                                style: TextStyle(
                                  color: ColorConstant.primeryColor,
                                  fontWeight: FontWeight.w500,
                                ),),
                          onPressed: () {
                                FirebaseFirestore.instance.collection('login_users').doc(widget.user!.id).update(
                                    widget.user!.copyWith(username: nameController.text).toMap());
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(
                              builder: (context) => HomePage1(userId: widget.user?.id??'', userName: '',)), ModalRoute.withName("/"));
                          },
                          ),
                          CupertinoDialogAction(
                              child: Text("Cancel",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.fifthColor
                                ),),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          )
                        ],
                      );
                    },
                  );
          
                },
                child: Container(
                  height: height*0.065,
                  width: width*0.708,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width*0.09),
                      border: Border.all(color: ColorConstant.primeryColor,width: width*0.005)
                  ),
                    child:   Center(child: Text("Update",
                      style: TextStyle(
                        fontSize: width*0.05,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.primeryColor,
                      ),
                    )),
                  ),
                ),
            ]),
        )
        ,)
    );
  }
}
