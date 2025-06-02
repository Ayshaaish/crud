import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class User{
  final String name;
  final String address;
  const User(
      this.name,
      this.address
      );
  User copyWith({String?name, String? address,}){
    return User(
      name?? this.name,
      address??this.address,
    );
  }
  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      'name':name,
      'address':address,
    };
  }
  factory User.fromMap(Map<String,dynamic>map){
    return User(
      map['name']as String,
      map['address']as String,
    );
  }
  String toJson()=>json.encode(toMap());
  factory User.fromJson(String source)=>User.fromJson(json.decode(source)as String);
  @override
  String toString()=> 'User(name:$name,address:$address)';
  @override
  bool operator ==(covariant User other) {
    if(identical(this , other)) return true ;
    return
    other.name==name&&
    other.address==address;
  }
@override
  int get hashCode=>name.hashCode ^ address.hashCode;
}


class UserNotifier extends StateNotifier<User>{
  UserNotifier(super.state);
  void updateName(String newValue){
    state=state.copyWith(name: newValue);
  }
  void updateAddress(String newAddress){
    state=state.copyWith(name: newAddress);
  }
}
final userProvider=StateNotifierProvider<UserNotifier,User>((ref) => UserNotifier(const User('Ripples Code','India')),);
class UserHomePage extends ConsumerWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Build method is called");
    final user=ref.watch(userProvider.select((value) => value.name,));//select method
    // final user=ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onSubmitted: (value) => ref.read(userProvider.notifier).updateName(value),
            ),
            SizedBox(height: 10,),
            TextField(
              onSubmitted: (value) => ref.read(userProvider.notifier).updateAddress(value),
            ),
            SizedBox(height: 10,),
            Text(user)
          ],
        ),
      ),
    );
  }
}

