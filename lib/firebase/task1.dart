import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String selectedRole = 'viewer';
  List<String> rolesToFilter = ['admin', 'editor', 'viewer'];
  List<TaskModel> users = [];


   addUser() async {
    final query = FirebaseFirestore.instance.collection('task').doc();
    TaskModel newUser = TaskModel(
      id: query.id,
      username: nameController.text.trim(),
      email: emailController.text.trim(),
      role: selectedRole,
    );
    await query.set(newUser.toMap());
    getUser();
  }

 getUser() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('task')
        .where('role', whereIn: rolesToFilter)
        .get();

    setState(() {
      users = snapshot.docs.map((doc) => TaskModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

 updateUserRole(String userId, String newRole) async {
    await FirebaseFirestore.instance.collection('task').doc(userId).update({
      'role': newRole,
    });
    getUser();
  }

     deleteUser(String userId) async {
    await FirebaseFirestore.instance.collection('task').doc(userId).delete();
    getUser();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Management"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add User Form
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            DropdownButton<String>(
              value: selectedRole,
              items: ['admin', 'editor', 'viewer'].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: addUser,
              child: Text('Add User'),
            ),

            SizedBox(height: 20),

            // Filter Buttons
            ToggleButtons(
              isSelected: ['admin', 'editor', 'viewer'].map((role) => rolesToFilter.contains(role)).toList(),
              onPressed: (index) {
                setState(() {
                  String role = ['admin', 'editor', 'viewer'][index];
                  if (rolesToFilter.contains(role)) {
                    rolesToFilter.remove(role);
                  } else {
                    rolesToFilter.add(role);
                  }
                });
                getUser();
              },
              children: ['Admin', 'Editor', 'Viewer']
                  .map((role) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(role),
              ))
                  .toList(),
            ),


            SizedBox(height: 20),
            // Users List
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.username),
                    subtitle: Text('${user.email} - ${user.role}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: user.role,
                          items: ['admin', 'editor', 'viewer'].map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              updateUserRole(user.id, value);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteUser(user.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TaskModel {
  String id;
  String username;
  String email;
  String role;

  TaskModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
    );
  }
}
