import 'package:crud/todooos/secondtodo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  DateTime selectedDate = DateTime.now();

  Stream<QuerySnapshot> getTodoStream() {
    return FirebaseFirestore.instance.collection('todo').snapshots();
  }

  void updateTaskStatus(String docId, bool isCompleted) {
    FirebaseFirestore.instance.collection('todo').doc(docId).update({
      'completed': isCompleted,
    });
  }

  void deleteTask(String docId) {
    FirebaseFirestore.instance.collection('todo').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int totalDays = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[200],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[300],
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoList2(isEditMode: false,)));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Month Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
                    });
                  },
                ),
                Text(
                  DateFormat('MMMM yyyy').format(selectedDate),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
                    });
                  },
                ),
              ],
            ),

            // Date Picker
            Container(
              height: height * 0.10,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: totalDays,
                itemBuilder: (context, index) {
                  DateTime date = DateTime(selectedDate.year, selectedDate.month, index + 1);
                  bool isSelected = DateFormat('yyyy-MM-dd').format(date) == selectedDateStr;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;  // Update selected date
                      });
                    },
                    child: Container(
                      width: width * 0.17,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.005, vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink[300] : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(40, 40),
                          topLeft: Radius.elliptical(40, 40),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat('E').format(date), style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black)),
                          SizedBox(height: height * 0.005),
                          Text(
                            DateFormat('d').format(date),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.03),

            Expanded(
              child: StreamBuilder(
                stream: getTodoStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  List<DocumentSnapshot> allTasks = snapshot.data!.docs;

                  List<DocumentSnapshot> selectedDateTasks = allTasks.where((doc) {
                    String taskDate = doc['date'];
                    return taskDate == selectedDateStr && !(doc['completed'] ?? false);
                  }).toList();

                  // Only show completed tasks and reminders if the selected date is today
                  bool isToday = DateFormat('yyyy-MM-dd').format(selectedDate) == DateFormat('yyyy-MM-dd').format(DateTime.now());

                  List<DocumentSnapshot> reminders = isToday
                      ? allTasks.where((doc) {
                    String taskDate = doc['date'];
                    return taskDate.compareTo(selectedDateStr) > 0 && !(doc['completed'] ?? false);
                  }).toList()
                      : [];

                  List<DocumentSnapshot> completedTasks = isToday
                      ? allTasks.where((doc) {
                    return (doc['completed'] ?? false);
                  }).toList()
                      : [];

                  return ListView(
                    children: [
                      if (selectedDateTasks.isNotEmpty)
                        buildTaskSection("Tasks for ${DateFormat('yyyy-MM-dd').format(selectedDate)}", selectedDateTasks, width),
                      if (selectedDateTasks.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'No tasks for this date',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                          ),
                        ),
                      if (isToday && reminders.isNotEmpty)
                        buildTaskSection("Upcoming Reminders", reminders, width),
                      if (isToday && completedTasks.isNotEmpty)
                        buildTaskSection("Completed Tasks", completedTasks, width),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTaskSection(String title, List<DocumentSnapshot> tasks, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
        ...tasks.map((doc) {
          bool isCompleted = doc['completed'] ?? false;

          return Slidable(
            key: Key(doc.id),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoList2(isEditMode: true, task: doc,)));
                    print("Edit Task: ${doc.id}");
                  },
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    deleteTask(doc.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task deleted")));
                  },
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            child: Container(
              width: width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    shape: CircleBorder(),
                    checkColor: Colors.grey[700],
                    activeColor: Colors.grey,
                    value: isCompleted,
                    onChanged: (value) {
                      updateTaskStatus(doc.id, value!);
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "📅 ${doc['date']}",
                            style: TextStyle(fontSize: width * 0.035, color: isCompleted ? Colors.grey : Colors.black87),
                          ),
                          SizedBox(height: 5),
                          Text(
                            doc['title'],
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold,
                              decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                              color: isCompleted ? Colors.grey : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "📝 ${doc['notes']}",
                            style: TextStyle(fontSize: width * 0.035, color: isCompleted ? Colors.grey : Colors.black87), // Dim notes text
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

