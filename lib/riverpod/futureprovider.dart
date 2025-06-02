import 'dart:convert';

import 'package:crud/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class DemoModel{
  final String firstname;
  final String lastname;
  final String avatar;
  final int id;
  final String email;

  DemoModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.id,
    required this.avatar,
});
  factory DemoModel.fromJson(Map<String,dynamic>json){
    return DemoModel(
        firstname: json['first_name'],
        lastname: json['last_name'],
        email: json['email'],
        id: json['id']??0,
        avatar: json['avatar'],
    );
  }
}
class ApiService{
  String endpoint = 'https://reqres.in/api/users?page=1';
  Future<List<DemoModel>> getUser()async{
    Response response=await get(Uri.parse(endpoint));
    if(response.statusCode==200){
      final List result =jsonDecode(response.body)['data'];
      return result.map(((e) => DemoModel.fromJson(e))).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}
class ApiHome extends ConsumerWidget {
  const ApiHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    final userData=ref.watch(userDataProvider);
    return Scaffold(
      appBar:AppBar(
        title:Text('Api Home'),
        centerTitle: true,
      ),
      body: userData.when(data: (data){
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text("${data[index].firstname}${data[index].lastname}"),
            subtitle: Text(data[index].email),
            leading: CircleAvatar(child: Image.network(data[index].avatar),),
          );
        },);},
        error: ((error ,stackTrace){
          print(error);
          return Text(error.toString());
        }),
        loading: ((){
        return const Center(child: CircularProgressIndicator(),);
      }
      )),

    );
  }
}
