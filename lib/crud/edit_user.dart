import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/homepage2.dart';
import 'package:crud/constant/firebaseconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../modalclass.dart';
import '../main.dart';

class EditUser extends StatefulWidget {
final String?id;
  const EditUser({super.key, required this.id,});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  bool eye=false;
  bool lock=false;

  // final passwordValidation =
  // RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
  // final emailValidation = RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

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
  generateSearchKey(String name) {
    List<String> searchKeys = [];
    String lowerName = name.toLowerCase();
    List<String> nameParts = lowerName.split(' ');
    for (String item in nameParts) {

      for (int i = 1; i <= item.length; i++) {
        searchKeys.add(item.substring(0, i));
      }
    }

    return searchKeys.toSet().toList();
  }
  UserModel? querydata;
  editData() async {
    print(widget.id);
    DocumentSnapshot query = await FirebaseFirestore.instance.collection(FirebaseConstants.users).doc(widget.id).get();
    querydata=UserModel.fromMap(query.data()as Map<String,dynamic>);
    setState(() {
      print(querydata);
  });
        }
  @override
  void initState(){
    editData();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    nameController.text=querydata?.username??'';
    passwordController.text=querydata?.password??'';
    emailController.text=querydata?.email??'';
    confirmpasswordController.text=querydata?.confirmpassword??'';
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:  EdgeInsets.all(width*0.03),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),
        title:Text("Edit User",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: width*0.05,
          ),),
        centerTitle: true,
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(width*0.05),
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
                                    // Navigator.pop(context, MaterialPageRoute(builder: (context) => EditUser(),));
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
              SizedBox(height: height*0.03,),
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,//button
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(width*0.03),
                      child: SvgPicture.asset(SvgImageConstant.svguser),
                    ),
                    labelText: "Username",
                    labelStyle: TextStyle(
                        color: ColorConstant.thirdColor
                    ),
                    hintText: "please enter your name",
                    enabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstant.thirdColor
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(
                        color: ColorConstant.thirdColor,
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
                    padding: EdgeInsets.all(width*0.03),
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
                        padding: EdgeInsets.all(width*0.03),
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
                obscureText: lock,
                controller: confirmpasswordController,
                textCapitalization: TextCapitalization.words,//button
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
          
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(width*0.03),
                      child: InkWell(
                          onTap: () {
                            lock=!lock;
                          setState(() {

                          });
                            },
                          child: SvgPicture.asset(lock?SvgImageConstant.svgpasslock:SvgImageConstant.svgopenlock)),
                    ),
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                        color: ColorConstant.thirdColor
                    ),
                    hintText: "please enter your name",
                    enabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstant.thirdColor
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(
                        color:ColorConstant.thirdColor
                      ),
                    )
                ),
              ),
              SizedBox(height: height*0.07,),
              InkWell(
          
                onTap: () {
                  showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        actions: [
                          CupertinoDialogAction(
                              child: Text("Are you Sure You Want to Update Details ?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.thirdColor,
          
                                ),)),
                          CupertinoDialogAction(
                              child: Text("Confirm",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  color: ColorConstant.primeryColor,
                                ),),
                            onPressed: ()  {
                              FirebaseFirestore.instance.collection(FirebaseConstants.users).doc(widget.id)
                                  .update(querydata?.copyWith(username: nameController.text,
                                  email:emailController.text, password:passwordController.text,
                                  confirmpassword: confirmpasswordController.text,searchkey:generateSearchKey(nameController.text) ).toMap());
                             Navigator.pushAndRemoveUntil(context, CupertinoDialogRoute(builder: (context) => HomePage2(info:widget.id.toString(),), context: context),ModalRoute.withName("/"));
                              print(widget.id);
                                // Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage2(),));
                              }),
                          CupertinoDialogAction(
                              child: Text("Cancel",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.fifthColor
          
                                ),),
                            onPressed: () {
                              // Navigator.pop(context, MaterialPageRoute(builder: (context) => EditUser(),));
                            },

                          )
                        ],
                      );
                    },
                  );

                },
                child: Container(
                  height: height*0.065,
                  width: width*0.705,
                  decoration: BoxDecoration(
                      color: ColorConstant.secondaryColor,
                      borderRadius: BorderRadius.circular(width*0.09),
                      border: Border.all(color: ColorConstant.primeryColor,width: width*0.005)
                  ),
                  child: Center(child: Text("Edit User",
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
