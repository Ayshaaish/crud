// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class NotifierHome extends ConsumerWidget {
//   const NotifierHome({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final counter=ref.watch(counterNotifierProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Notifier Demo"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(counter.toString(),style: TextStyle(fontSize: 40),),
//           SizedBox(height: 20,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     ref.read(counterNotifierProvider.notifier).incremnt();
//                   },
//                   child: Text('+',style: TextStyle(fontSize: 40),),
//               ),
//               SizedBox(width: 15,),
//               ElevatedButton(
//                 onPressed: () {
//                  ref.read(counterNotifierProvider.notifier).decrement();
//                 },
//                 child: Text('-',style: TextStyle(fontSize: 40),),
//               ),
//             ],
//           )
//           ],
//       ),
//     );
//   }
// }
// class CounterNotifier extends Notifier<int>{
//   @override
//   int build() {
//     return 0;
//   }
//   void incremnt(){
//     state++;
//   }
//   void decrement(){
//     state--;
//   }
// }
// final counterNotifierProvider=NotifierProvider<CounterNotifier,int>((){
//   return CounterNotifier();
// });
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'notifier.g.dart';

/// notifier and notifier using riverpod generator

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() {
    return 0;
  }
  void incremnt(){
    state++;
  }
  void decrement(){
    state--;
  }
}
class NotifierHome extends ConsumerWidget {
  const NotifierHome({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final counter= ref.watch(counterNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('notifier provider using riverpod generator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(counter.toString(),style: TextStyle(fontSize: 20),),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).incremnt();
                  },
                  child: Text('+',style: TextStyle(fontSize: 15),)
              ),
              SizedBox(width: 15,),
              ElevatedButton(
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).decrement();
                  },
                  child: Text('-',style: TextStyle(fontSize: 15),)
              ),
            ],
          )
        ],
      ),
    );
  }
}
