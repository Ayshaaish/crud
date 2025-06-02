import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// read by extending consumerwidget
// import 'package:crud/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class NameProvider extends ConsumerWidget {
//   const NameProvider({super.key});
//
//   Widget build(BuildContext context, WidgetRef ref) {
//     final name=ref.watch(nameProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('RiverPod Provider '),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(name),
//       ),
//     );
//   }
// }
/// call using consumer
// import 'package:crud/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class NameProvider extends StatelessWidget {
//   const NameProvider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('RiverPod Provider '),
//         centerTitle: true,
//       ),
//       body: Center(
//         child:Consumer(builder: (context, ref, child) {
//           final name = ref.watch(nameProvider);
//           return Text(name);
//         },),
//       ),
//     );
//   }
// }
/// statefullwidget
class NameProvider extends ConsumerStatefulWidget {
  const NameProvider({super.key});

  @override
 _NameProviderState createState() => _NameProviderState();
}

class _NameProviderState extends ConsumerState<NameProvider> {
  @override
  void initState() {
  final name=ref.read(nameProvider);
  print(name);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final name= ref.watch(nameProvider) ;
    return Scaffold(
      body: Center(
        child: Text(name),
      ),
    );
  }
}

