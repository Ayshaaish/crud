import 'package:crud/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class User extends Equatable {
  final String name;
  final String address;

  const User(this.name, this.address);

  @override
  List<Object?> get props => [name, address];
}
class MainHome extends ConsumerStatefulWidget {
  const MainHome({super.key});

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends ConsumerState<MainHome> {
  @override
  Widget build(BuildContext context) {
    final name=ref.watch(nameFamilyProvider(User('aysha','abcd')));
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Modifier'),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
