import 'package:crud/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Streamprovider extends ConsumerWidget {
  const Streamprovider({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final streamData=ref.watch(streamProvider);
    return Scaffold(
appBar: AppBar(
  title: Text('Stream Provider'),
),
      body: streamData.when(data: (data) => Center(child: Text(data.toString(),style: TextStyle(fontSize: 25),),),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
