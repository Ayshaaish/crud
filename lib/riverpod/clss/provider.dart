import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import 'cmnvar.dart';

class ProviderPage extends StatelessWidget{
  const ProviderPage({super.key});

  @override

  Widget build(BuildContext context,) {
    TextEditingController nameController=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        ///provider
        title: Consumer(builder: (context, ref, child) {
          return Text(ref.watch(nameProvider));
        },),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///state provider
            Consumer(builder: (context, ref, child) {
              return Column(
                children: [
                  Text(ref.watch(studentProvider)),
                  TextField(controller: nameController,
                      onChanged: (value){ ref.read(studentProvider.notifier).update((state) => value);}
                  ),
                ],
              );
            },),
            SizedBox(height: 25,),
            ElevatedButton(
                onPressed: () {
                  // ref.read(studentProvider.notifier).state=nameController.text;
                },
                child: Text("Submit")
            ),
            SizedBox(height: 45,),
            Consumer(
              builder: (context, ref, child) {
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        ref.watch(counterProvider.notifier).state++;
                      },
                      child: Icon(Icons.add),
                    ),
                    SizedBox(width: 20,),
                    Text('0'),
                    SizedBox(width: 20,),
                    FloatingActionButton(
                      onPressed: () {
                        ref.watch(counterProvider.notifier).state--;
                      },
                      child: Icon(Icons.minimize),
                    ),
                  ],
                ) ;
              },

            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../globel/common_var.dart';
// class CounterScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final count = ref.watch(counterProvider);
//     return Scaffold(
//       appBar: AppBar(title: Text('StateNotifier Example')),
//       body:    Center(
//         child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: () {
//                       ref.read(counterProvider.notifier).state++;
//                     },
//                     child: Icon(Icons.add),
//                   ),
//                   SizedBox(width: 20,),
//                   Text('$count'),
//                   SizedBox(width: 20,),
//                   FloatingActionButton(
//                     onPressed: () {
//                     ref.watch(counterProvider.notifier).state--;
//                     },
//                     child: Icon(Icons.minimize),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }