import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../crud/add_user.dart';


class AddedUser extends StatefulWidget {
  const AddedUser({super.key});

  @override
  State<AddedUser> createState() => _AddedUserState();
}

class _AddedUserState extends State<AddedUser> {
  List<dynamic> like = [];
  final TextEditingController searchController = TextEditingController();
  String search = "";


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUser(),
              ));
        },
        backgroundColor:Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: Text("Hello, User", style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Users",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: width * 0.05),
            ),

            /// User List
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('adds').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('User not found'));
                  }
                  var users = snapshot.data!.docs.map((doc) => AddUserModel.fromMap(doc.data())).toList();

                  return ListView.separated(
                    itemCount: users.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var user = users[index];

                      return Container(
                        height: height * 0.08,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.03),
                          boxShadow: [
                            BoxShadow(
                              color:Colors.black.withOpacity(0.15),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: width * 0.05,
                            backgroundImage: NetworkImage(user.image),
                          ),
                          title: Text(user.username, style: TextStyle(fontWeight: FontWeight.w700)),
                          subtitle: Text(
                            user.email,
                            style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w700),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [


                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: height * 0.03),
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
class AddUserModel{
  String id;
  String email;
  String password;
  String username;
  String confirmpassword;
  String  image;
  AddUserModel(  { required this.image,required this.email,required this.password,required this.username,required this.confirmpassword,required this.id});

  Map<String,dynamic> toMap(){
    return {
      "email":this.email,
      "password":this.password,
      "username":this.username,
      "confirmpassword":this.confirmpassword,
      "id":this.id,
      "image":this.image??[]
    };
  }
  factory AddUserModel.fromMap(Map<String,dynamic>map){
    return AddUserModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      confirmpassword: map['confirmpassword'],
      id: map['id'],
      image: map['image'],

    );
  }
  copyWith({
    String? email,
    String? password,
    String? username,
    String? confirmpassword,
    String? id,
    String?image,
  } ){
    return AddUserModel(
      email: email??this.email,
      password: password??this.password,
      username: username??this.username,
      confirmpassword: confirmpassword??this.confirmpassword,
      id: id??this.id,
      image:image??this.image ,
    );
  }
}