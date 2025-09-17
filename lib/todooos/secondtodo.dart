import 'package:crud/todooos/todoss.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class ToDoList2 extends StatefulWidget {
  final bool isEditMode;
  final DocumentSnapshot? task;

  const ToDoList2({super.key, required this.isEditMode, this.task});

  @override
  _ToDoList2State createState() => _ToDoList2State();
}

class _ToDoList2State extends State<ToDoList2> {
  DateTime selectedDate = DateTime.now();
  TextEditingController taskController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode && widget.task != null) {
      taskController.text = widget.task?['title'] ?? '';
      notesController.text = widget.task?['notes'] ?? '';
      selectedDate = DateTime.parse(widget.task?['date'] ?? DateTime.now().toString());

      String? taskTime = widget.task?['time'];
      if (taskTime != null && taskTime != 'No time selected') {

        List<String> timeParts = taskTime.split(':');
        if (timeParts.length == 2) {
          int hour = int.parse(timeParts[0]);
          int minute = int.parse(timeParts[1].split(' ')[0]);
          setState(() {

            if (taskTime.contains('AM') && hour == 12) {
              hour = 0;
            }
            if (taskTime.contains('PM') && hour != 12) {
              hour += 12;
            }
            selectedTime = TimeOfDay(hour: hour, minute: minute);
          });
        }
      }
    }
  }

  // Add new task
  addTask() {
    if (taskController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('todo').add({
        'title': taskController.text,
        'notes': notesController.text,
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'time': selectedTime != null ? selectedTime!.format(context) : 'No time selected',
        'completed': false,
      });

      taskController.clear();
      notesController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task Added Successfully!')),
      );
    }
  }

  // Update task
  updateTask() {
    if (taskController.text.isNotEmpty && widget.task != null) {
      FirebaseFirestore.instance.collection('todo').doc(widget.task!.id).update({
        'title': taskController.text,
        'notes': notesController.text,
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'time': selectedTime != null ? selectedTime!.format(context) : 'No time selected',
        'completed': widget.task?['completed'],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task Updated Successfully!')),
      );

      Navigator.pop(context);
    }
  }

  // Show time picker dialog
  showTimePickerDialog() async {
    // Show the built-in time picker dialog
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Edit Task' : 'Add Task', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Picker Section
              Container(
                width: Width,
                padding: EdgeInsets.all(Width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('EEEE, d MMMM').format(selectedDate),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: Height * 0.01),

                    // Calendar Picker
                    SizedBox(
                      height: Height * 0.35,
                      child: CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          selectedDayHighlightColor: Colors.pink[200],
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                          dayBorderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(20, 20),
                            topLeft: Radius.elliptical(20, 20),
                          ),
                        ),
                        value: [selectedDate],
                        onValueChanged: (dates) {
                          if (dates.isNotEmpty && dates[0] != null) {
                            setState(() {
                              selectedDate = dates[0]!; // Set the selected date
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Height * 0.02),

              // Task Title & Notes Section
              Container(
                width: Width,
                padding: EdgeInsets.all(Width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.isEditMode ? "Edit Task" : "New Task", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: Height * 0.01),
                    TextField(
                      controller: taskController,
                      decoration: InputDecoration(
                        labelText: "Enter Task Title",
                      ),
                    ),
                    SizedBox(height: Height * 0.02),
                    TextField(
                      controller: notesController,
                      decoration: InputDecoration(
                        labelText: "Notes",
                      ),
                    ),
                    SizedBox(height: Height * 0.02),
                    Text(
                      selectedTime == null
                          ? 'No time selected'
                          : 'Selected Time: ${selectedTime?.format(context)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: Height * 0.02),

                    // Button to show TimePicker
                    SizedBox(
                      width: Width,
                      child: ElevatedButton(
                        onPressed: showTimePickerDialog, // Show dialog on press
                        child: Text("Select Time"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.pink[200],
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: Height * 0.01),

                    // Add or Update Task Button
                    SizedBox(
                      width: Width,
                      child: ElevatedButton(
                        onPressed: widget.isEditMode ? updateTask : addTask, // Decide function based on mode
                        child: Text(widget.isEditMode ? "Update Task" : "Add Task"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[300],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
