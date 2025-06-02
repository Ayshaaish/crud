import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'riverpod_generator.g.dart';
// final nameGenerateProvider= Provider<String>((ref) => 'ABC',);

@Riverpod(keepAlive: true)
String name(NameRef ref){
  return "ABC";
}
class FirstPage extends ConsumerWidget {
  const FirstPage ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name =ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpod Generator"),
      ),
      body: Center(
        child:Text(name),
      ),
    );
  }
}
