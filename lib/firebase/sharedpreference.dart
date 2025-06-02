import 'package:crud/firebase/sharedpreference2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';
import '../main.dart';

class SharedPreference extends StatefulWidget {
  const SharedPreference({super.key});

  @override
  State<SharedPreference> createState() => _SharedPreferenceState();
}
class _SharedPreferenceState extends State<SharedPreference> {

///username
//   setUserName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.setString('username', nameController.text);
//     Navigator.push(context, MaterialPageRoute(builder: (context) => Page2(),));
//   }
// TextEditingController nameController=TextEditingController();

///usernumber
  setUserNumber() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setInt('usernumber',int.parse(numberController.text) );
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page2(),));
  }
  TextEditingController numberController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("username"),
        centerTitle:true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TextFormField(
            //   controller: nameController,
            //   textCapitalization: TextCapitalization.words,//button
            //   keyboardType: TextInputType.multiline,
            //   textInputAction: TextInputAction.next,
            //   decoration: InputDecoration(
            //       suffixIcon: Padding(
            //         padding:EdgeInsets.all(width*0.03),
            //         child: SvgPicture.asset(SvgImageConstant.svguser),
            //       ),
            //       labelText: "Username",
            //       labelStyle: TextStyle(
            //           color: ColorConstant.thirdColor
            //       ),
            //       hintText: "please enter your name",
            //       enabledBorder:OutlineInputBorder(
            //           borderSide: BorderSide(
            //               color:ColorConstant.thirdColor
            //           )),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(width*0.03),
            //         borderSide: BorderSide(
            //             color: ColorConstant.thirdColor
            //         ),
            //       )
            //   ),
            // ),
            SizedBox(height: height*0.05,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: numberController,
              maxLength: 10,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  counterText: '',
                  suffixIcon:Icon(Icons.phone),
                  labelText: "number",
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                  hintText: "please enter your contact number",
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  )
              ),
            ),

            SizedBox(height: height*0.05,),
            InkWell(
              onTap: () {
                setUserNumber();
              },
              child: Container(
                height: height*0.06,
                width: width*0.4,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(width*0.05)
                ),
                child: Center(child: Text("Click")),
              ),
            )
          ],
        ),
      ),
    );
  }
}

