import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color_constant.dart';
import '../constant/image_contant.dart';
import '../main.dart';

class HomeNew extends StatefulWidget {
  const HomeNew({super.key});

  @override
  State<HomeNew> createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('name'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
       children: [
         ListView.separated(
           itemCount: 3,
           shrinkWrap: true,
           itemBuilder: (BuildContext context, int index) {
             return  Container(
               height: height * 0.08,
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
                 title: Text('jii'),
                 subtitle: Text('hiii'),
                 trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
                     InkWell(
                       onTap: () {

                       },
                       child: SvgPicture.asset(
                       SvgImageConstant.svgdelete),
                     ),
               SizedBox( width: width*0.03,),
               InkWell(
                 onTap: () {

                 },
                 child: SvgPicture.asset(
                     SvgImageConstant.svghomepen),
               ),
               ])
               ),
             );
           },
           separatorBuilder: (BuildContext context, int index) { return SizedBox(height: height*0.03,);},

         ) ],
       ),
     ),
    );
  }
}
