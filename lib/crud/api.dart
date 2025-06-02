import 'dart:convert';

import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/homepage1.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart'as http;

class PostalCodes extends StatefulWidget {
  const PostalCodes({super.key});

  @override
  State<PostalCodes> createState() => _PostalCodesState();
}

class _PostalCodesState extends State<PostalCodes> {
  TextEditingController pinCodeController=TextEditingController();
  List code=[];
  getData() async {
    Uri? uri=Uri.tryParse("https://api.postalpincode.in/pincode/${pinCodeController.text}");
    http.Response data=await http.get(uri!);
    var apiResponce = data.body ;
    List apiData = jsonDecode(apiResponce) ;
    print(apiData);
    code = apiData[0]["PostOffice"];
    print(code);
    setState(() {
    });
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
              padding: EdgeInsets.all(width*0.03),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),

        title: Text("Postal Codes",
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),),
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: pinCodeController,
              onFieldSubmitted: (value) {
                getData();
              },
              textCapitalization: TextCapitalization.words,//button
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,

              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(width*0.03),
                  child: SvgPicture.asset(SvgImageConstant.svgsearch,color: ColorConstant.primeryColor,),
                ),
                  labelText: "Pincode",
                  labelStyle: TextStyle(
                      color: ColorConstant.thirdColor
                  ),
                  // hintText: "please enter your name",
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

            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: code.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: height*0.09,
                    width: width*1,
                    decoration: BoxDecoration(
                        color: ColorConstant.secondaryColor,
                        borderRadius: BorderRadius.circular(width*0.03),
                        boxShadow: [
                          BoxShadow(
                              color: ColorConstant.thirdColor.withOpacity(0.15),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 5)),
                        ]
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Postoffice:${code[index]["Name"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),),
                          subtitle: Text("District:${code[index]['District']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),),
                        )
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: height*0.03,); },
              ),
            )
          ],
        ),
      ),
    );
  }
}
