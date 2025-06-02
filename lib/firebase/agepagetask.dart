// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crud/firebase/modalclass.dart';
// import 'package:crud/main.dart';
// import 'package:flutter/material.dart';
//
// import '../constant/color_constant.dart';
// import '../constant/firebaseconstant.dart';
//
// class AgeTask extends StatefulWidget {
//   final String? id;
//   const AgeTask({super.key, this.id});
//
//   @override
//   State<AgeTask> createState() => _AgeTaskState();
// }
//
// class _AgeTaskState extends State<AgeTask> {
//   final TextEditingController nameController = TextEditingController();
//   StudentModel?ModelClass;
//   getNameFunction() async {
//     print(widget.id);
//     ModelClass = await FirebaseFirestore.instance
//         .collection('Students')
//         .doc(widget.id)
//         .get()
//         .then(
//           (value) => StudentModel.fromMap(value.data() as Map<String, dynamic>),
//     );
//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     height =MediaQuery.of(context).size.height;
//     width =MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Model ${ModelClass?.name??''}'),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Find users'),
//               onChanged: (value) {
//                 setState(() {
//
//                 });
//               },
//             ),
//             SizedBox(height: height*0.03,),
//             StreamBuilder(
//               stream: nameController.text=='' ? FirebaseFirestore.instance.collection('Students').snapshots():
//               FirebaseFirestore.instance.collection('Students').where('age',isGreaterThanOrEqualTo: double.parse(nameController.text)).snapshots(),
//               builder: (context, snapshot) {
//              if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//              }
//               if (!snapshot.hasData) {
//              return Text("data not found");
//              }
//                 if (snapshot.hasError) {
//              return Text("Eroor");
//              } else {
//                   var Student = snapshot.data!.docs;
//                   return ListView.separated(
//                     itemCount: Student.length,
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return Container(
//                         height: height * 0.08,
//                         width: width,
//                         decoration: BoxDecoration(
//                           color: ColorConstant.secondaryColor,
//                           borderRadius: BorderRadius.circular(width * 0.03),
//                           boxShadow: [
//                             BoxShadow(
//                               color: ColorConstant.thirdColor.withOpacity(0.15),
//                               blurRadius: 5,
//                               spreadRadius: 2,
//                               offset: Offset(0, 5),
//                             ),
//                           ],
//                         ),
//                         child: ListTile(
//                           title: Text(Student[index]['name']),
//                           subtitle: Text(Student[index]['age'].toString()),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return SizedBox(height: height * 0.03,);
//                     },
//
//                   );
//                 }
//               },
//
//             ),
//
//           ],
//         ),
//
//       ),
//     );
//   }
// }
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/modalclass.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class AgeTask extends StatefulWidget {
  final Map<String, dynamic> userData;

  const AgeTask({super.key, required this.userData,});

  @override
  State<AgeTask> createState() => _AgeTaskState();
}

class _AgeTaskState extends State<AgeTask> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcom, ${widget.userData['name']}"),  // Show logged-in user name
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Find users by age'),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: StreamBuilder(
                stream: nameController.text.isEmpty
                    ? FirebaseFirestore.instance.collection('Students').snapshots()
                    : FirebaseFirestore.instance
                    .collection('Students')
                    .where('age', isGreaterThanOrEqualTo: double.tryParse(nameController.text) ?? 0)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading data"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No users found"));
                  }

                  var students = snapshot.data!.docs;

                  return ListView.separated(
                    itemCount: students.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var student = students[index];
                      return Container(
                        height: height * 0.08,
                        width: width,
                        decoration: BoxDecoration(
                          color: ColorConstant.secondaryColor,
                          borderRadius: BorderRadius.circular(width * 0.03),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.thirdColor.withOpacity(0.15),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(student['name']),
                          subtitle: Text('Age: ${student['age'].toString()}'),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: height * 0.03);
                    },
                  );
                },
              ),
            ),
            Text("Name: ${widget.userData['name']}"),
            Text("Email: ${widget.userData['email']}"),
            Text("age: ${widget.userData['age'] ?? 'Not Available'}",),
          ],
        ),
      ),
    );
  }
}
