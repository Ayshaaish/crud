import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/add_user.dart';
import 'package:crud/crud/edit_user.dart';
import 'package:crud/crud/homepage1.dart';
import 'package:crud/crud/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../modalclass.dart';

class HomePage2 extends StatefulWidget {
  final String info;
  const HomePage2({super.key, required this.info});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  List<dynamic> like = [];
  final TextEditingController searchController = TextEditingController();
  String search = "";

  /// Fetch user favorites from Firestore
  void likeGetFunction() async {
    var datas = await FirebaseFirestore.instance
        .collection("login_users")
        .doc(widget.info)
        .get();
    like = datas.data()?['favorite'] ?? [];
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
    likeGetFunction();
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
        backgroundColor: ColorConstant.primeryColor,
        child: Icon(Icons.add, color: ColorConstant.secondaryColor),
      ),
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                  context);
            },
            child: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: SvgPicture.asset(SvgImageConstant.svgbackbutton),
            )),
        title: Text("Hello, User", style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: CircleAvatar(
              radius: width * 0.05,
              backgroundImage: AssetImage(ImageConstant.profile),
            ),
          ),
          SizedBox(width: width * 0.03),
        ],
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search Input Field
            TextField(
              controller: searchController,
              decoration: InputDecoration(labelText: 'Find users'),
              onChanged: (value) {
                setState(() {
                  search = searchController.text.toLowerCase();
                });
              },
            ),
            SizedBox(height: 10),

            Text(
              "Current Users",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: width * 0.05),
            ),

            /// User List
            Expanded(
              child: StreamBuilder(
                stream:
                search.isEmpty
                    ? FirebaseFirestore.instance.collection('users').snapshots()
                    : FirebaseFirestore.instance
                    .collection('users')
                    .where('searchkey', arrayContains: search )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('User not found'));
                  }
                  var users = snapshot.data!.docs.map((doc) => UserModel.fromMap(doc.data())).toList();

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
                          color: ColorConstant.secondaryColor,
                          borderRadius: BorderRadius.circular(width * 0.03),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.thirdColor.withOpacity(0.15),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: width * 0.05,
                            backgroundImage: AssetImage(ImageConstant.profile),
                          ),
                          title: Text(user.username, style: TextStyle(fontWeight: FontWeight.w700)),
                          subtitle: Text(
                            user.email,
                            style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w700),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// Like Button
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (like.contains(user.id)) {
                                        like.remove(user.id);
                                      } else {
                                        like.add(user.id);
                                      }
                                      FirebaseFirestore.instance
                                          .collection('login_users')
                                          .doc(widget.info)
                                          .update({'favorite': like});
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    SvgImageConstant.svglike,
                                    color: like.contains(user.id)
                                        ? ColorConstant.fifthColor
                                        : ColorConstant.primeryColor,
                                  )),
                              SizedBox(width: width * 0.03),

                              /// Delete Button
                              InkWell(
                                  onTap: () {
                                    showCupertinoDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text("Delete User?"),
                                          content: Text("Are you sure you want to delete this user?"),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text("Yes", style: TextStyle(color: Colors.red)),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .delete();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text("Cancel"),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(SvgImageConstant.svgdelete)),
                              SizedBox(width: width * 0.03),

                              /// Edit Button
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditUser(id: user.id),
                                        ));
                                  },
                                  child: SvgPicture.asset(SvgImageConstant.svghomepen)),
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
