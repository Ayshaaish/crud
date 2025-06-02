
import 'package:crud/constant/color_constant.dart';
import 'package:crud/firebase/edittask.dart';
import 'package:crud/riverpod/autodisposemodifier.dart';
import 'package:crud/riverpod/autodisposemodifier2.dart';
import 'package:crud/riverpod/darkmode.dart';
import 'package:crud/riverpod/familymodifier.dart';
import 'package:crud/riverpod/filter_listview.dart';
import 'package:crud/riverpod/futureprovider.dart';
import 'package:crud/riverpod/navigationbar.dart';
import 'package:crud/riverpod/notifier.dart';
import 'package:crud/riverpod/provider.dart';
import 'package:crud/riverpod/riverpod_generator.dart';
import 'package:crud/riverpod/stateprovider.dart';
import 'package:crud/riverpod/streamprovider.dart';
import 'package:crud/todooos/splashh.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase/addsettask.dart';
import 'firebase/agepagetask.dart';
import 'firebase/api.dart';
import 'firebase/getmethod.dart';
import 'firebase/gettaskk.dart';
import 'firebase/listen.dart';
import 'firebase/login_task.dart';
import 'ml_kit/scan_and_speak.dart';
import 'ml_kit/ml_kit.dart';
import 'firebase/task1.dart';
import 'firebase/noteapptask.dart';
import 'firebase/readtask.dart';
import 'firebase/sharedpreference.dart';
import 'firebase/splash.dart';

import 'todooos/todoss.dart';
import 'firebase_options.dart';
import 'crud/add_user.dart';
import 'crud/api.dart';
import 'crud/banner.dart';
import 'crud/edit_user.dart';
import 'crud/homepage1.dart';
import 'crud/homepage2.dart';
import 'crud/login.dart';
import 'crud/login_signup.dart';
import 'crud/otp.dart';
import 'crud/phone.dart';
import 'crud/profile.dart';
import 'crud/signup.dart';
import 'crud/splash.dart';
late double height;
late double width;
String currentUserName='';
int currentUserNumber=0;
///statenotifier
final counterProvider=StateNotifierProvider<CounterDemo,int>((ref)=>CounterDemo());
// final counterProvider=StateProvider<int>(
//   (ref)=>0,
// );
///read provider
final nameProvider=Provider<String>((ref){
  return "hello world";
});
/// future provider
final apiProvider=Provider<ApiService>((ref) => ApiService(),);
final userDataProvider=FutureProvider<List<DemoModel>>((ref) {
  return ref.read(apiProvider).getUser();
},);
/// stream provider
final streamProvider=StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(seconds: 2),(computationCount) => computationCount,);
},);
///auto dispose modifier
final GoRouter _router=GoRouter(routes:[
  GoRoute(path:"/" , builder: (context,state)=>const Home()),
  GoRoute(path:"/counter",builder: (context,state)=>const Counter())
]);
///autodispose
final counterAutoProvider=StateNotifierProvider.autoDispose<CounterDemo,int>((ref) {
  ref.keepAlive(); // if we want to preserve the state
  // final link=ref.keepAlive();
  // final timer=Timer( const Duration(seconds: 10),(){
  //   link.close();
  // });
  // ref.onDispose(() => timer.cancel());
  return CounterDemo();
},);
///family provider multiple and single value
// final nameFamilyProvider=Provider.family<String,String>(
//   (ref, name) {
//     return "hello $name";
//   },
// );// single value
final nameFamilyProvider=Provider.family<String, User>(
  (ref, User) {
    return "hellow ${User.name} and address: ${User.address}";
  },
);
///theme
final themeProvider=StateProvider<bool>((ref) => true,);



Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ProviderScope(child: MyApp()),
    ),
  );
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // final themeMode =ref.watch(themeNotifierProvider);
    return GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus!.unfocus();
    },
      child: MaterialApp(
        // theme:
        // ThemeData(
        //         scaffoldBackgroundColor: ColorConstant.secondaryColor,
        //           textTheme: GoogleFonts.poppinsTextTheme()
        //       ),
        //       debugShowCheckedModeBanner: false,
        // themeMode: themeMode,
        debugShowCheckedModeBanner: false,
           home:ImageTextScanner(),

      ),
      // child: MaterialApp.router(
      //   routerConfig: _router,
      // ),
    );
  }
}


