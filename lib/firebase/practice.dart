
/// to add on firebase (example)
// addNote(){
//   NoteModel note=NoteModel(
//     title: addtitleContoller.text,
//     content: addcontentContoller.text,
//     id: '',
//   );
//
//   FirebaseFirestore.instance.collection('notes').add(note.toMap()).then((value) {
//     value.update({
//       'id':value.id
//     });
//   });
//   addcontentContoller.clear();
//   addtitleContoller.clear();
// }

/// login with get and where condition (example)
// loginWithgetMethod() async {
//   if (nameController.text.isEmpty) {
//     showUploadMessage('Please enter username', context);
//     return;
//   }
//   if (emailController.text.isEmpty) {
//     showUploadMessage('Please enter email', context);
//     return;
//   }
//   QuerySnapshot data = await FirebaseFirestore.instance
//       .collection('Students')
//       .where('name', isEqualTo: nameController.text).where('email', isEqualTo: emailController.text)
//       .get();
//   if(emailController.text.isNotEmpty && nameController.text.isNotEmpty){
//     Map<String,dynamic> userData=data.docs[0].data() as Map<String,dynamic>;
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AgeTask(userData: userData,)),
//     );
//   }
//   if (data.docs.isEmpty) {
//     showUploadMessage('User does not exist', context);
//     return;
//   } else {
//     if (data.docs[0]['email'] == emailController.text) {
//
//     } else {
//       showUploadMessage('Wrong email', context);
//     }
//   }
// }

/// to set on fiirebase (example)
// creatUser() async {
//   await FirebaseAuth.instance
//       .createUserWithEmailAndPassword(
//       email: emailController.text, password: passwordController.text)
//       .then(
//         (value) async {
//       final uid=value.user?.uid??'';
//       await  FirebaseFirestore.instance
//           .collection("login_users")
//           .doc(value.user!.uid)
//           .set({
//         "username":nameController.text,
//         "email":emailController.text,
//         "password":passwordController.text,
//         "confirmpassword":confirmpasswordController.text,
//         'id':uid,
//         "favorite":[]
//       }).then((value) =>Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),)),);
//     },
//   );
// }

/// update (example)
// FirebaseFirestore.instance.collection(FirebaseConstants.users).doc(widget.id)
//     .update(querydata?.copyWith(username: nameController.text,
// email:emailController.text, password:passwordController.text,
// confirmpassword: confirmpasswordController.text,searchkey:generateSearchKey(nameController.text) ).toMap());
// Navigator.pushAndRemoveUntil(context, CupertinoDialogRoute(builder: (context) => HomePage2(info:widget.id.toString(),), context: context),ModalRoute.withName("/"));
// print(widget.id);

/// getmethod (example)
// UserModel? querydata;
// editData() async {
//   print(widget.id);
//   DocumentSnapshot query = await FirebaseFirestore.instance.collection(FirebaseConstants.users).doc(widget.id).get();
//   querydata=UserModel.fromMap(query.data()as Map<String,dynamic>);
//   setState(() {
//     print(querydata);
//   });
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
//
// class NewTaskScreen extends StatefulWidget {
//   @override
//   _NewTaskScreenState createState() => _NewTaskScreenState();
// }
//
// class _NewTaskScreenState extends State<NewTaskScreen> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   TextEditingController notesController = TextEditingController();
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }
//
//   void _addTaskToFirebase() {
//     FirebaseFirestore.instance.collection('tasks').add({
//       'meeting': 'UX Case',
//       'notes': notesController.text,
//       'date': DateFormat('yyyy-MM-dd').format(selectedDate),
//       'time': selectedTime.format(context),
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task Added!')));
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(Icons.arrow_back, size: 28),
//                 Text("New Task", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 Text(DateFormat('EEEE d MMMM').format(DateTime.now()),
//                     style: TextStyle(color: Colors.grey)),
//               ],
//             ),
//             SizedBox(height: 20),
//             CalendarDatePicker(
//               initialDate: selectedDate,
//               firstDate: DateTime(2020),
//               lastDate: DateTime(2030),
//               onDateChanged: (date) {
//                 setState(() {
//                   selectedDate = date;
//                 });
//               },
//             ),
//             SizedBox(height: 70),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("New Task", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),
//                   Text("Meeting: UX Case", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//                   SizedBox(height: 10),
//                   Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
//                   TextField(
//                     controller: notesController,
//                     decoration: InputDecoration(hintText: "Discuss Milton"),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () => _selectDate(context),
//                         child: Text("Another Day"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () => _selectTime(context),
//                         child: Text("Pick Time"),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text("Time: ${selectedTime.format(context)}", style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: _addTaskToFirebase,
//                     child: Text("Add Task"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
