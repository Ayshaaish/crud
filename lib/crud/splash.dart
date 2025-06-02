
import 'package:crud/constant/color_constant.dart';
import 'package:crud/crud/homepage1.dart';
import 'package:crud/crud/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userId;
 checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    userId = prefs.getString('userId') ?? '';

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? HomePage1(userId: userId!, userName: '',) : LoginSignup(),
        ),
      );
    });
  }
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstant.primeryColor,
      body: Center(
        child: Text(
          "CRUD",
          style: TextStyle(
            fontSize: width * 0.08,
            fontWeight: FontWeight.w900,
            color: ColorConstant.secondaryColor,
          ),
        ),
      ),
    );
  }
}
// import 'package:crud/constant/color_constant.dart';
// import 'package:crud/crud/homepage1.dart';
// import 'package:crud/crud/login_signup.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../main.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key,});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   // bool pass=false;
//   // getSharePref() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   pass= prefs.getBool('login')!;
//   //   setState(() {
//   //
//   //   });
//   // }
//   // getUserName() async {
//   //   SharedPreferences prefs=await SharedPreferences.getInstance();
//   //   currentUserName=prefs.getString('username')??'';
//   //
//   //   setState(() {
//   //   });
//   // }
//   void initState() {
//     getUserName();
//     Future.delayed(
//         Duration(seconds: 3)).then((value) =>   Navigator.pushReplacement(context, MaterialPageRoute(
//       builder: (context) =>currentUserName.isEmpty?LoginSignup():HomePage1(userId:''),)),);
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     height=MediaQuery.of(context).size.height;
//     width=MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: ColorConstant.primeryColor,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("CRUD",
//               style:TextStyle(
//                   fontSize: width*0.08,
//                 fontWeight: FontWeight.w900,
//                 color: ColorConstant.secondaryColor
//               ) ,
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }
