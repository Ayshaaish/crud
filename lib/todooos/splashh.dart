import 'package:crud/constant/color_constant.dart';
import 'package:crud/todooos/todoss.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplahToDo extends StatefulWidget {
  const SplahToDo({super.key});

  @override
  State<SplahToDo> createState() => _SplahToDoState();
}

class _SplahToDoState extends State<SplahToDo> {
  splash() async {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ToDoList(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    splash();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[200]!,
              Colors.pink[500]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/Animation - 1742669721644.json',
                width: width * 0.8,
                height: height * 0.4,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              // Text Below Animation
              Text(
                "Get things done",
                style: TextStyle(
                  fontSize: width * 0.1,
                  fontWeight: FontWeight.w900,
                  color: ColorConstant.secondaryColor,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(4.0, 4.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:crud/constant/color_constant.dart';
// import 'package:crud/todooos/todoss.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// class SplahToDo extends StatefulWidget {
//   const SplahToDo({super.key});
//
//   @override
//   State<SplahToDo> createState() => _SplahToDoState();
// }
//
// class _SplahToDoState extends State<SplahToDo> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> offsetAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize the Animation Controller
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//
//     // Create a Tween for the slide effect
//     offsetAnimation = Tween<Offset>(
//       begin: Offset(0, -8), // Start position (above the screen)
//       end: Offset(0, 0),    // End position (original position)
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOut, // Smooth animation curve
//     ));
//
//     // Start the animation
//     _controller.forward();
//
//     // Navigate to the ToDoList screen after 4 seconds
//     Future.delayed(const Duration(seconds: 4), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ToDoList(),
//         ),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.pink[200]!,
//               Colors.pink[500]!,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Lottie.asset(
//                 'assets/lottie/Animation - 1742669721644.json',
//                 width: width * 0.8,
//                 height: height * 0.4,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(height: 20),
//               // Text below animation with slide effect
//               SlideTransition(
//                 position: offsetAnimation,
//                 child: Text(
//                   "Get things done",
//                   style: TextStyle(
//                     fontSize: width * 0.1,
//                     fontWeight: FontWeight.w900,
//                     color: ColorConstant.secondaryColor,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 10.0,
//                         color: Colors.black.withOpacity(0.5),
//                         offset: Offset(4.0, 4.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
