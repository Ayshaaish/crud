import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends ConsumerWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final counter=ref.watch(counterAutoProvider);
    return Scaffold(
appBar: AppBar(
  title: Text('counter'),
),
      body: Center(
        child:Text('$counter',style: TextStyle(fontSize: 25),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      ref.read(counterAutoProvider.notifier).increment();
      },
        child: Icon(Icons.add),),
    );
  }
}
