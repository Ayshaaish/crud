import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/firebaseconstant.dart';
import 'package:crud/modalclass.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class GetMethod extends StatefulWidget {
 // final String?id;
  const GetMethod({super.key,});

  @override
  State<GetMethod> createState() => _GetMethodState();
}

class _GetMethodState extends State<GetMethod> {
  // var queryData;
  UserModel? users;
List queryData=[];
QuerySnapshot? listenDataSnap;
  // getDataA() async {
  //   QuerySnapshot query = await FirebaseFirestore.instance.collection('get').get();
  //   print(query.docs);
  //   queryData=query.docs;
  //   setState(() {
  //
  //   });
  //
  //   DocumentSnapshot doc=await FirebaseFirestore.instance.collection('get').doc(widget.id).get();
  //     users = UserModel.fromMap(doc.data() as Map<String, dynamic>);
  //     setState(() {});
  // }
  listenData(){
    FirebaseFirestore.instance.collection('users').snapshots().listen((event){
      listenDataSnap=event;
    });
  }
  @override
  Widget build(BuildContext context) {
    height =MediaQuery.of(context).size.height;
    width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(queryData.toString()),
        // listenDataSnap==null?Container():  Column(
        //     children:List.generate(
        //         listenDataSnap!.docs.length,
        //         (index) => Text(listenDataSnap!.docs[index]['username']),
        //     )
        //   ),

        Column(
            children:List.generate(
                queryData.length,
                (index) => Text(queryData[index]['username']),
            )
          ),
          Text("============="),
       users==null?Text("data"):   Text(users!.username.toString()),
          Center(
           child:  ElevatedButton(
             onPressed: () {
               listenData();
               // getDataA();
             },
             child: Text('Get'),
           ),
          ),
        ],
      ),
    );
  }
}

