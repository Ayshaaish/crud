import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/modalclass.dart';
import 'package:crud/firebase/readtask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';
import '../main.dart';

class GetClss extends StatefulWidget {
  const GetClss({super.key});

  @override
  State<GetClss> createState() => _GetClssState();
}
bool get=true;
List datas=[];
class _GetClssState extends State<GetClss> {
  getReadData() async {
    get=false;
    setState(() {

    });
    QuerySnapshot query = await FirebaseFirestore.instance.collection('userss').get();
    datas=query.docs;
    setState(() {

      get=true;
    });
    // print(datas?[0]['name']);
  }
  @override
  Widget build(BuildContext context) {
    height= MediaQuery.of(context).size.height;
    width= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Get'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            get==true? ListView.builder(
        shrinkWrap: true,
          itemCount:datas?.length??0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(datas?[index]['name']??0),
              subtitle: Text(datas?[index]['email']??0),
              trailing: Icon(Icons.add),
            );
          },
        ) :CircularProgressIndicator(),
            ElevatedButton(
                onPressed: () {
                  getReadData();
                },
                child: Text('Get')
            ),

          ],
        ),
      ),
    );
  }
}
