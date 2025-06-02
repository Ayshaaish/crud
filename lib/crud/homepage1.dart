import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/constant/color_constant.dart';
import 'package:crud/constant/image_contant.dart';
import 'package:crud/crud/api.dart';
import 'package:crud/crud/banner.dart';
import 'package:crud/crud/favuserr.dart';
import 'package:crud/crud/homepage2.dart';
import 'package:crud/crud/login_signup.dart';
import 'package:crud/crud/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../modalclass.dart';
import '../main.dart';

class HomePage1 extends StatefulWidget {
  final String userId;
  final String userName;
  HomePage1({super.key,  required this.userId, required this.userName});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  int selectedintex = 0;
  // List boxes = [
  //   {
  //     "image": ImageConstant.sliderimage1,
  //     "color": ColorConstant.primeryColor,
  //   },
  //   {
  //     "image": ImageConstant.sliderimage2,
  //     "color": ColorConstant.primeryColor,
  //   },
  //   {
  //     "image": ImageConstant.sliderimage3,
  //     "color": ColorConstant.primeryColor,
  //   },
  // ];
  List boxes2 = [
    {"gridimage": ImageConstant.homegrid1, "text": "CRUD"},
    {
      "gridimage": ImageConstant.homegrid1,
      "text": "Cloud Storage for firebase"
    },
    {"gridimage": ImageConstant.homegrid3, "text": "API"},
    {"gridimage": ImageConstant.favuser,
    "text":"favourite users"
    }
  ];
  List pages = [];
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  // getUserName() async {
  //   // sharedpreference
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   currentUserName = prefs.getString('username') ?? '';
  //   setState(() {});
  // }

  UserModel? ModelClass;
  getUserDetails() async {
    print(widget.userId);
    ModelClass = await FirebaseFirestore.instance
        .collection('login_users')
        .doc(widget.userId)
        .get()
        .then(
          (value) => UserModel.fromMap(value.data() as Map<String, dynamic>),
        );
    setState(() {});
  }
   logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginSignup()),
            (route) => false
    );
  }

  @override
  void initState() {
    // getUserName();
    getUserDetails();
    super.initState();
  }
  // removeUserName() async {
  //   SharedPreferences prefs=await SharedPreferences.getInstance();
  //   prefs.remove('username');
  //   prefs.clear();
  // }

  Widget build(BuildContext context) {
    pages=[
      HomePage2(info: widget.userId,),
      BannerPage(),
      PostalCodes(),
      FavUsers(userId: widget.userId,)
    ];
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello ${ModelClass?.username??''}",
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile(user: ModelClass!,)));
            },
            child: CircleAvatar(
              radius: width * 0.05,
              backgroundImage: AssetImage(ImageConstant.profile),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          InkWell(
              onTap: () {
                logout();
              },
              child: SvgPicture.asset(SvgImageConstant.svglogout))
        ],
        backgroundColor: ColorConstant.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
            CarouselSlider.builder(
              carouselController: carouselSliderController,
              itemCount: 3,
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedintex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  height: height * 0.01,
                  width: width * 1,
                  margin: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.sliderr),
                        fit: BoxFit.fill),
                  ),
                );
              },
            ),
            AnimatedSmoothIndicator(
              activeIndex: selectedintex,
              count: 3,
              effect: JumpingDotEffect(
                activeDotColor: ColorConstant.primeryColor,
                dotColor: ColorConstant.forthColor,
                dotHeight: height * 0.01,
                dotWidth: width * 0.02,
              ),
              onDotClicked: (index) {
                carouselSliderController.jumpToPage(index);
              },
            ),
            SizedBox(
              height: height * 0.06,
            ),
            GridView.builder(
              itemCount: boxes2.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.03,
                mainAxisSpacing: width * 0.03,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pages[index],
                        ));
                  },
                  child: Container(
                    height: height * 0.301,
                    width: width * 0.475,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(boxes2[index]["gridimage"])),
                        color: ColorConstant.secondaryColor,
                        borderRadius: BorderRadius.circular(width * 0.03),
                        boxShadow: [
                          BoxShadow(
                              color: ColorConstant.thirdColor.withOpacity(0.15),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 5)),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          boxes2[index]["text"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
