
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// stateProvider
// import 'package:crud/constant/messengerconstant.dart';
// import 'package:crud/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class CounderProvider extends ConsumerWidget {
//   const CounderProvider({super.key});
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     ref.listen(counterProvider, (previous, next) {
//       if(next==5){
//         showUploadMessage("the value is $next", context);
//       }
//     },);
//     final count=ref.watch(counterProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("State Provider"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 // ref.invalidate(counterProvider);
//                 ref.refresh(counterProvider);
//               },
//               icon: Icon(Icons.refresh)
//           ),
//         ],
//       ),
//       body: Center(
//         child:Text(count.toString(),style: TextStyle(
//           fontSize: 30,
//         ),),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         // ref.read(counterProvider.notifier).state++;
//         ref.read(counterProvider.notifier).update((state)=>state+1);
//       },
//       child:Icon(Icons.add),
//       ),
//     );
//
//   }
// }
/// StateNotifier Provider-extension
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// class CounterScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final count = ref.watch(counterProvider); // read state
//
//     return Scaffold(
//       appBar: AppBar(title: Text('StateNotifier Example')),
//       body: Center(child: Text('Count: $count')),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             onPressed: () => ref.read(counterProvider.notifier).increment(),
//             child: Icon(Icons.add),
//           ),
//           SizedBox(height: 10),
//           FloatingActionButton(
//             onPressed: () => ref.read(counterProvider.notifier).decrement(),
//             child: Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// extension on StateController<int> {
//   void increment() {
//     state++;
//   }
//
//   void decrement() {
//     state--;
//   }
// }
///class vedio
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  Widget build(BuildContext context,WidgetRef ref) {
    final counter=ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("State Notifier"),
      ),
    body: Center(
        child:Text('$counter',style: TextStyle(
          fontSize: 30,
        ),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(counterProvider.notifier).increment();
      },
      child:Icon(Icons.add),
      ),
    );
  }
}

class CounterDemo extends StateNotifier<int>{
  CounterDemo():super(0);
  void increment(){
    state++;
  }
}

