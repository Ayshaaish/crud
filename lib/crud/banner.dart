import 'dart:io';

import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';
import 'add_user.dart';
import 'homepage1.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  List boxes1 = [
    {"image": ImageConstant.sliderimage3, "text": "Banner 1"},
    {"image": ImageConstant.sliderimage2, "text": "Banner 2"},
    {"image": ImageConstant.sliderimage1, "text": "Banner 3"},
  ];
  TextEditingController nameController = TextEditingController();
  var file;
  pickFile(ImageSource) async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource);
    if (mounted) {
      file = File(imageFile!.path);
      setState(() {});
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
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage1(userId: '',userName: '',),
                  ));
            },
            child: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),
        title: Text(
          "Banner",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: width * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
           // file!=null? InkWell(
           //      onTap: () {
           //        showCupertinoModalPopup(
           //          context: context,
           //          builder: (context) {
           //            return CupertinoActionSheet(
           //              actions: [
           //                CupertinoActionSheetAction(
           //                    onPressed: () {
           //                      pickFile(ImageSource.gallery);
           //                    },
           //                    child: Text("Photo Gallery")),
           //                CupertinoActionSheetAction(
           //                    onPressed: () {
           //                      pickFile(ImageSource.camera);
           //                    },
           //                    child: Text("Camera")),
           //              ],
           //              cancelButton: CupertinoActionSheetAction(
           //                child: Text(
           //                  "Cancel",
           //                  style: TextStyle(
           //                    fontWeight: FontWeight.w700,
           //                    color: ColorConstant.fifthColor,
           //                  ),
           //                ),
           //                onPressed: () {
           //                  Navigator.pop(
           //                      context,
           //                      MaterialPageRoute(
           //                        builder: (context) => BannerPage(),
           //                      ));
           //                },
           //              ),
           //            );
           //          },
           //        );
           //      },
           //      child: Image(image: FileImage(file),)):
            InkWell(
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
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.fifthColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BannerPage(),
                                ));
                          },
                        ),
                      );
                    },
                  );
                },
        child: Container(
          height: height*0.23,
          width: width*0.87,
          decoration: BoxDecoration(
            // color: Colors.red,
            image: DecorationImage(image: file!=null?FileImage(file):AssetImage(ImageConstant.frame),fit: BoxFit.fill)
          ),
        ),),
            SizedBox(
              height: height * 0.04,
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
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Banner",
                labelStyle: TextStyle(color: ColorConstant.primeryColor),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstant.primeryColor)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  borderSide: BorderSide(
                    color: ColorConstant.primeryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            InkWell(
              onTap: () {
                showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      actions: [
                        CupertinoDialogAction(
                            child: Text("Are you Sure You Want to upload banner?",
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
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>BannerPage() ,));

                          },
                        ),
                        CupertinoDialogAction(
                          child: Text("Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.fifthColor
                            ),),
                          onPressed: () {
                            Navigator.pop(context, MaterialPageRoute(builder: (context) => BannerPage(),));
                          },
                        )
                      ],
                    );
                  },
                );
                // Navigator.push(context, MaterialPageRoute(builder: (context) => OTP(),));


              },
              child: Container(
                height: height * 0.065,
                width: width * 0.708,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    border: Border.all(
                        color: ColorConstant.primeryColor,
                        width: width * 0.005)),
                child: Center(
                    child: Text(
                  "Upload Banner",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.primeryColor,
                  ),
                )),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                      height: height * 0.14,
                      width: width * 1,
                      decoration: BoxDecoration(
                          color: ColorConstant.secondaryColor,
                          borderRadius: BorderRadius.circular(width * 0.03),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    ColorConstant.thirdColor.withOpacity(0.15),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 5)),
                          ]),
                      child: Row(
                        children: [
                          Container(
                            height: height * 0.09,
                            width: width * 0.3,
                            child: Image(
                              image: AssetImage(boxes1[index]["image"]),
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Container(
                            height: height * 0.09,
                            width: width * 0.2,
                            // color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  boxes1[index]["text"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width * 0.04,
                                      color: ColorConstant.primeryColor),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  "2 May",
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.3,
                          ),
                          InkWell(
                              onTap: () {
                                showCupertinoDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text(
                                              "Are you Sure You Want to Delete Banner?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.thirdColor,
                                          ),
                                        )),
                                        CupertinoDialogAction(
                                            child: Text(
                                              "Yes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.fifthColor),
                                        ),
                                    onPressed: () {
                                    Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) =>
                                    BannerPage(),
                                    ));
                                    },
                                    ),
                                        CupertinoDialogAction(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.primeryColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BannerPage(),
                                                ));
                                            },
                                        ),
                                      ],);
                                  },
                                );
                              },
                              child: SvgPicture.asset(SvgImageConstant.svgdelete)),
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: height * 0.03,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
