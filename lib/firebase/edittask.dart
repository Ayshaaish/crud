import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/firebaseconstant.dart';
import 'package:crud/main.dart';
import 'package:crud/modalclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';

class EditTask extends StatefulWidget {
  final String? id;
  const EditTask({super.key,required this.id});


  @override
  State<EditTask> createState() => _EditTaskState();
}
class _EditTaskState extends State<EditTask> {
  bool eye =false;
  TextEditingController passwordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
    TestModel? queryData;
  getReadData() async {
    print(widget.id);
    DocumentSnapshot query = await FirebaseFirestore.instance.collection('userss').doc(widget.id).get();
    queryData=TestModel.fromMap(query.data()as Map<String,dynamic>);
    setState(() {
      print(queryData);
    });
  }
  @override
  void initState() {
    getReadData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    nameController.text=queryData?.name??'';
    passwordController.text=queryData?.password??'';
    emailController.text=queryData?.email??'';
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Edit'),centerTitle: true,backgroundColor: Colors.white,),
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
            SizedBox(
              height: height*0.07,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    // print(queryData);
              FirebaseFirestore.instance.collection('userss').doc(widget.id).
              update(queryData?.copyWith(name: nameController.text,
                  email:emailController.text, password:passwordController.text).toMap());
               Navigator.pop(context);
                  },
                  child: Text('edit')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
