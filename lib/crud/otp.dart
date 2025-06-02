import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/homepage1.dart';
import 'package:crud/crud/login.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
        title: Text(
          "Verify OTP",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: width * 0.04,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage(ImageConstant.otp),
              width: width * 0.952,
              height: height * 0.362,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("OTP has been sent to *****634",style: TextStyle(color: ColorConstant.primeryColor),)),
                SizedBox(width: width*0.03,),
                SvgPicture.asset(SvgImageConstant.svgspenotp)
              ],
            ),
            SizedBox(height: height*0.02,),
            Pinput(
              length: 6,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(fontSize: 20, color:ColorConstant.thirdColor),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstant.primeryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            InkWell(
              onTap: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage1(userId: '', userName: '',),),ModalRoute.withName("/"));
        
              },
              child: Container(
                height: height * 0.068,
                width: width * 0.708,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.09),
                    border: Border.all(
                        color: ColorConstant.primeryColor, width: width * 0.005)),
                child:Center(
                      child: Text(
                    "Verify",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.primeryColor,
                    ),
                  )),
              ),
            ),
            SizedBox(height: height*0.02,),
            Center(child: Text("Haven't got the confirmation code yet? Resend",
            style: TextStyle(
              fontWeight: FontWeight.w700,
                fontSize: width*0.03
            ),)),
            SizedBox(height: height*0.16,),
            Center(child: Text("Try Another Method?",
              style: TextStyle(
              fontWeight: FontWeight.w700,
                  fontSize: width*0.03
            ),),)
          ],
        ),
      ),
    );
  }
}
