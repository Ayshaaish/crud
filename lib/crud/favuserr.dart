import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/color_constant.dart';
import '../modalclass.dart';

class FavUsers extends StatefulWidget {
  final String userId;
  const FavUsers({super.key, required this.userId});

  @override
  State<FavUsers> createState() => _FavUsersState();
}

class _FavUsersState extends State<FavUsers> {
  List<UserModel>fav=[];
  favouriteGet() async {
   var userdoc= await FirebaseFirestore.instance.collection('login_users').doc(widget.userId).get();
           List favs=(userdoc.data()!['favorite']);
print(favs);
for(int i=0;i<favs.length;i++){
  UserModel? userModel;
  await FirebaseFirestore.instance.collection('users').doc(favs[i]).get().then((value) {
     userModel=UserModel.fromMap(value.data()!);
   },);
  fav.add(userModel!);
setState(() {
  
});

}
print(fav);
  }

  @override
  void initState() {
    favouriteGet();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  height =MediaQuery.of(context).size.height;
  height =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Favourite users'),centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(width*0.03),
        child: Column(
          children: [
            Expanded(
        child: ListView.separated(
          itemCount: fav.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: height * 0.2,
              width: width * 1,
              decoration: BoxDecoration(
                  color: ColorConstant.secondaryColor,
                  borderRadius:
                  BorderRadius.circular(width * 0.03),
                  boxShadow: [
                    BoxShadow(
                        color: ColorConstant.thirdColor
                            .withOpacity(0.15),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 5)),
                  ]),
              child: ListTile(
                title: Text(fav[index].username),
                subtitle: Text(fav[index].email),
                trailing: InkWell(
                    onTap: () async {
                      var userDoc = await FirebaseFirestore.instance.collection('login_users').doc(widget.userId).get();
                      List<dynamic> favorites =userDoc.data()?['favorite'] ?? [];
                      favorites.remove(fav[index].id);
                      await FirebaseFirestore.instance.collection('login_users').doc(widget.userId).update({'favorite': favorites});
                      setState(() => fav.removeAt(index));
                    },

                    child: SvgPicture.asset(SvgImageConstant.svglike,color:ColorConstant.fifthColor)),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: height*0.03,);},
        
        ),
            )],
        ),
      ),
    );

  }
}
