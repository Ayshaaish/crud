import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/modalclass.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import 'addsettask.dart';
import 'edittask.dart';
import '../constant/firebaseconstant.dart';

class ReadTask extends StatefulWidget {
  const ReadTask({super.key});

  @override
  State<ReadTask> createState() => _ReadtaskState();
}

class _ReadtaskState extends State<ReadTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSetTaskPage1(),));
        },
        backgroundColor: ColorConstant.primeryColor,
        child: Icon(Icons.add,color: ColorConstant.secondaryColor,),

      ),
      appBar: AppBar(
        title: Text("read"),
centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection(FirebaseConstants.userss).snapshots()
                  .map((event) => event.docs.map((e)=> TestModel.fromMap(e.data())).toList(),),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Text("data not fount");
                }
                if (snapshot.hasError) {
                  return Text("Eroor");
                } else {
                  var product = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(product[index].name),
                            subtitle: Text(product[index].email),
                            trailing: InkWell(
                                onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>EditTask(id: product[index].id,) ,));
                                },
                                child: Icon(Icons.add))

                        );
                      },


                    ),
                  );
                }

              }

            ),
          ],
        ),
      ),
    );
  }
}
