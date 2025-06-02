import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/modalclass.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool note=false;
  final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final TextEditingController addtitleContoller=TextEditingController();
    final TextEditingController addcontentContoller=TextEditingController();
    addNote(){
      NoteModel note=NoteModel(
          title: addtitleContoller.text,
          content: addcontentContoller.text,
        id: '',
      );

      FirebaseFirestore.instance.collection('notes').add(note.toMap()).then((value) {
        value.update({
          'id':value.id
        });
      });
      addcontentContoller.clear();
      addtitleContoller.clear();
    }
    bool get=true;
    List notedatas=[];
  NoteModel? newNote;

  getNote() async {
    get=false;
    setState(() {

    });
          DocumentSnapshot getnotee= await FirebaseFirestore.instance.collection('notes').doc().get();
newNote=NoteModel.fromMap(getnotee.data()as Map<String,dynamic>);
setState(() {
  note=true;
});
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Notes",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[400],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('add note' ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: addtitleContoller, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: addcontentContoller, decoration: InputDecoration(labelText: 'Content')),
          ],),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")
            ),
            ElevatedButton(
                onPressed: () {
                  addNote();
                  Navigator.pop(context);
                },
                child: Text('Add')
            ),
        ],
      ));},
        backgroundColor: Colors.green[400],
        child: Icon(Icons.add,color: ColorConstant.secondaryColor,),
      ),
      body:Column(
        children: [
          StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('notes').snapshots()
                .map((event) => event.docs.map((e)=> NoteModel.fromMap(e.data())).toList(),),
            builder: (context, snapshot) {
    // if (!snapshot.hasData) {
    // return Center(child: CircularProgressIndicator());
    // }
           if (!snapshot.hasData) {
           return Text("data not fount");
           }
           if (snapshot.hasError) {
            return Text("Eroor");
           } else {
            var added = snapshot.data!;
            return Expanded(
             child: ListView.builder(
              itemCount: added.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  newNote = added[index];
                  String? id = added[index].id;
                  // print("${id} iddddddddddddddddddd");
                  TextEditingController titleController =
                  TextEditingController(text: added[index].title);
                  TextEditingController contentController =
                  TextEditingController(text: added[index].content);


                  showDialog(
                      context: context,

                      builder: (context) =>
                          AlertDialog(
                            title: Text('Edit Note'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                        labelText: 'Title')),
                                TextField(
                                    controller: contentController,
                                    decoration: InputDecoration(
                                        labelText: 'Content')),
                              ],),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    print(added[index].id);
                                    FirebaseFirestore.instance.collection('notes')
                                        .doc(added[index].id)
                                        .update(newNote?.copyWith(
                                        title: titleController.text,
                                        content: contentController.text).toMap());
                                    Navigator.pop(context);
                                  },
                                  child: Text('Update')
                              ),
                            ],
                          ));
                },
                child: ListTile(
                  title: Text(added[index].title),
                  subtitle: Text(added[index].content),
                  trailing: InkWell(
                      onTap: () {
                        FirebaseFirestore.instance.collection('notes').doc(
                            added[index].id).delete();
                      },
                      child: Icon(Icons.delete)
                  ),
                ),

              );
            }),
      );
    }}),
        ],
      ),
    );
  }
}

















// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../constant/color_constant.dart';
//
// class NoteModel {
//   String id;
//   String title;
//   String content;
//   DateTime timestamp;
//
//   NoteModel({required this.id, required this.title, required this.content, required this.timestamp});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'content': content,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }
//
//   static NoteModel fromMap(Map<String, dynamic> map, String documentId) {
//     return NoteModel(
//       id: documentId,
//       title: map['title'],
//       content: map['content'],
//       timestamp: DateTime.parse(map['timestamp']),
//     );
//   }
// }
//
// class NotesScreen extends StatefulWidget {
//   @override
//   _NotesScreenState createState() => _NotesScreenState();
// }
//
// class _NotesScreenState extends State<NotesScreen> {
//   final notesCollection = FirebaseFirestore.instance.collection('notes');
//
//   void addNote(String title, String content) {
//     final newNote = notesCollection.doc();
//     newNote.set({
//       'title': title,
//       'content': content,
//       'timestamp': DateTime.now().toIso8601String(),
//     });
//   }
//
//   Stream<List<NoteModel>> getNotes() {
//     return notesCollection.orderBy('timestamp', descending: true).snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => NoteModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
//     });
//   }
//
//   void updateNote(String id, String title, String content) {
//     notesCollection.doc(id).update({
//       'title': title,
//       'content': content,
//       'timestamp': DateTime.now().toIso8601String(),
//     });
//   }
//
//   void deleteNote(String id) {
//     notesCollection.doc(id).delete();
//   }
//
//   void _showNoteDialog(BuildContext context, NoteModel? note) {
//     final TextEditingController titleController = TextEditingController(text: note?.title ?? '');
//     final TextEditingController contentController = TextEditingController(text: note?.content ?? '');
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(note == null ? 'Add Note' : 'Edit Note'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
//             TextField(controller: contentController, decoration: InputDecoration(labelText: 'Content')),
//           ],
//         ),
//         actions: [
//           TextButton(child: Text('Cancel'), onPressed: () => Navigator.pop(context)),
//           ElevatedButton(
//             child: Text(note == null ? 'Add' : 'Update'),
//             onPressed: () {
//               if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
//                 if (note == null) {
//                   addNote(titleController.text, contentController.text);
//                 } else {
//                   updateNote(note.id, titleController.text, contentController.text);
//                 }
//               }
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Real-Time Notes')),
//       body: StreamBuilder<List<NoteModel>>(
//         stream: getNotes(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//           final notes = snapshot.data!;
//           return ListView.builder(
//             itemCount: notes.length,
//             itemBuilder: (context, index) {
//               final note = notes[index];
//               return ListTile(
//                 title: Text(note.title),
//                 subtitle: Text(note.content),
//                 trailing: IconButton(
//                   icon: Icon(Icons.delete, color: Colors.red),
//                   onPressed: () => deleteNote(note.id),
//                 ),
//                 onTap: () => _showNoteDialog(context, note),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => _showNoteDialog(context, null),
//       ),
//     );
//   }
// }
