import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListenPage extends StatefulWidget {
  const ListenPage({super.key});

  @override
  State<ListenPage> createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {

 List  listendata=[];
  listenFunction() async {
   FirebaseFirestore.instance.collection('users').snapshots().listen((event) async {
      listendata = event.docs;

setState(() {

});
    },);
   // print(listendata!.docs[0]['username']);
    }
    @override
  void initState() {
    // TODO: implement initState
      listenFunction();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listendata.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listendata[index]['username']),
                  subtitle: Text(listendata[index]['email']),
                  trailing: InkWell(
                      onTap: () {
                        listenFunction();
                      },
                      child: Icon(Icons.add)),
                );
              },
            
            ),
          )
        ],
      ),
    );
  }
}
