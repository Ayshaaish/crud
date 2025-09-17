//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverbed/globel/common_var.dart';
//
//
// class CalculatorPage extends ConsumerWidget {
//   final buttons = [
//     'C', '+/-', '%', '÷',
//     '7', '8', '9', '×',
//     '4', '5', '6', '-',
//     '1', '2', '3', '+',
//     '0', '.', '='
//   ];
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final display = ref.watch(displayProvider);
//
//     void onButtonPressed(String button) {
//       final notifier = ref.read(displayProvider.notifier);
//
//       switch (button) {
//         case 'C':
//           notifier.state = '0';
//           break;
//         case '=':
//           break;
//         default:
//           if (display == '0') {
//             notifier.state = button;
//           } else {
//             notifier.state += button;
//           }
//       }
//     }
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: EdgeInsets.only(top: 0.9),
//         child: Column(
//           children: [
//             // Display
//             Expanded(
//               flex: 2,
//               child: Container(
//                 alignment: Alignment.bottomRight,
//                 padding: EdgeInsets.all(24),
//                 child: Text(
//                   display,
//                   style: TextStyle(fontSize: 60, color: Colors.white),
//                 ),
//               ),
//             ),
//             SizedBox(
//               child: Container(
//                 alignment: Alignment.bottomRight,
//                 padding: EdgeInsets.all(24),
//                 child: Text(
//                   '0',
//                   style: TextStyle(fontSize: 60, color: Colors.white),
//                 ),
//               ),
//             ),
//             // Buttons
//             Expanded(
//               flex: 5,
//               child: GridView.builder(
//                 padding: EdgeInsets.all(12),
//                 itemCount: buttons.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemBuilder: (context, index) {
//                   final button = buttons[index];
//                   Color buttonColor;
//                   if (button == 'C') {
//                     buttonColor = Colors.redAccent;
//                   } else if (['÷', '×', '-', '+', '='].contains(button)) {
//                     buttonColor = Colors.orange;
//                   } else {
//                     buttonColor = Colors.white24;
//                   }
//
//                   return InkWell(
//                     onTap: () => onButtonPressed(button),
//                     child: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: buttonColor,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: Text(
//                         button,
//                         style: TextStyle(
//                           fontSize: 28,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cmnvar.dart';

class CalculatorPage extends ConsumerWidget {
  final buttons = [
    'C', '+/-', '%', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', '='
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final display = ref.watch(displayProvider);
    final result = ref.watch(resultProvider);

    void onButtonPressed(String button) {
      final displayNotifier = ref.read(displayProvider.notifier);
      final resultNotifier = ref.read(resultProvider.notifier);

      switch (button) {
        case 'C':
          displayNotifier.state = '0';
          resultNotifier.state = '0';
          break;
        case '=':
          try {
            String exp = display.replaceAll('×', '*').replaceAll('÷', '/');
            List<String> parts = exp.split(RegExp(r'([+\-*/])')).map((e) => e.trim()).toList();
            List<String> ops = RegExp(r'[+\-*/]').allMatches(exp).map((m) => m.group(0)!).toList();

            double total = double.parse(parts[0]);

            for (int i = 0; i < ops.length; i++) {
              double next = double.parse(parts[i + 1]);
              switch (ops[i]) {
                case '+':
                  total += next;
                  break;
                case '-':
                  total -= next;
                  break;
                case '*':
                  total *= next;
                  break;
                case '/':
                  total /= next;
                  break;
              }
            }

            resultNotifier.state = total.toStringAsFixed(
              total.truncateToDouble() == total ? 0 : 2,
            );
          } catch (e) {
            resultNotifier.state = 'Error';
          }
          break;

        case '+/-':
          if (display.startsWith('-')) {
            displayNotifier.state = display.substring(1);
          } else {
            displayNotifier.state = '-$display';
          }
          break;

        default:
          if (display == '0' || display == 'Error') {
            displayNotifier.state = button;
          } else {
            displayNotifier.state += button;
          }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 0.9),
        child: Column(
          children: [
            // Display (Input)
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(24),
                child: Text(
                  display,
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
              ),
            ),

            // Result (Output)
            SizedBox(
              height: 80,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  result,
                  style: TextStyle(fontSize: 40, color: Colors.greenAccent),
                ),
              ),
            ),

            // Buttons
            Expanded(
              flex: 5,
              child: GridView.builder(
                padding: EdgeInsets.all(12),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final button = buttons[index];
                  Color buttonColor;

                  if (button == 'C') {
                    buttonColor = Colors.redAccent;
                  } else if (['÷', '×', '-', '+', '='].contains(button)) {
                    buttonColor = Colors.orange;
                  } else {
                    buttonColor = Colors.white24;
                  }

                  return InkWell(
                    onTap: () => onButtonPressed(button),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
