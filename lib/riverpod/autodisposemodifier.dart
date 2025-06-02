import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child:ElevatedButton(
            onPressed: () {
          context.push("/counter");
        },
            child: Text('Counter')),
      ),
    );
  }
}
