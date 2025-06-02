import 'dart:convert';

import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart'as http;

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';

class APIs extends StatefulWidget {
  const APIs({super.key});

  @override
  State<APIs> createState() => _APIsState();
}
class _APIsState extends State<APIs> {
  // List cat=[];
  // getData() async {
  //   Uri? uri=Uri.tryParse("https://api.thecatapi.com/v1/images/search");
  //   http.Response data=await http.get(uri!);
  //   var apiResponce = data.body ;
  //   List apiData = jsonDecode(apiResponce) ;
  //      cat = apiData;
  //      print(apiData);
  //      setState(() {
  //      });
  // }
  TextEditingController postalCodeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
height =MediaQuery.of(context).size.height;
width =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: postalCodeController,
              textCapitalization: TextCapitalization.words,//button
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: "pincode",
                  labelStyle: TextStyle(
                      color: ColorConstant.thirdColor
                  ),
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
            SizedBox(height: height*0.05,),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Lookup'),
            ),
          ],
        ),
      )
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //      spacing: height*0.02,
      //     children: [
      //       cat.isEmpty?Text("no image availabvle"):
      //       Container(
      //         height: height*0.25,
      //         width: width*0.45,
      //         child: Image.network(cat[0]['url'],fit: BoxFit.fill,),
      //         decoration: BoxDecoration(
      //           color: Colors.red,
      //         ),
      //       ),
      //       InkWell(
      //         onTap: () {
      //           getData();
      //         },
      //         child: Container(
      //           height: height*0.06,
      //           width: width*0.23,
      //           decoration: BoxDecoration(
      //             color: Colors.green[400],
      //                 borderRadius: BorderRadius.circular(width*0.07)
      //           ),
      //           child: Center(child: Text("Get")),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
