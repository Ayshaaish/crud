import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../main.dart';
import 'otp.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});
  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => Login(),));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),
        backgroundColor: ColorConstant.secondaryColor,
        title: Text("Enter Phone Number",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: width*0.06
          ),),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage(ImageConstant.phone)),
              IntlPhoneField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  )
                ),
                initialCountryCode: "IN",
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              SizedBox(height: height*0.05,),
              InkWell(
          
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OTP(),));
          
                },
                child: Container(
                  height: height*0.070,
                  width: width*0.708,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width*0.09),
                      border: Border.all(color: ColorConstant.primeryColor,width: width*0.005)
                  ),
                  child: Center(child: Text("Send OTP",
                      style: TextStyle(
                        fontSize: width*0.05,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.primeryColor,
                      ),
                    )),
                  ),
                ),
              SizedBox(height: height*0.3),
              Text("Sign in with Another Method ? ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.primeryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
