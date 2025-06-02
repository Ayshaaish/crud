import 'package:crud/riverpod/account.dart';
import 'package:crud/riverpod/gallery.dart';
import 'package:crud/riverpod/home.dart';
import 'package:crud/riverpod/navigation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class NavigationBarPage extends ConsumerWidget {
  const NavigationBarPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final index=ref.watch(navigationNotifierProvider);
    return Scaffold(
      body: [
        const HomePageForNavigation(),
        const GalleryPage(),
        const AccountPage()
      ][index],
     bottomNavigationBar: NavigationBar(
       destinations:[
         NavigationDestination(
           selectedIcon: Icon(Icons.home),
             icon: Icon(Icons.home_outlined),
             label: 'home'
         ),
         NavigationDestination(
           selectedIcon: Icon(Icons.browse_gallery),
             icon: Icon(Icons.browse_gallery_outlined),
             label: 'gallery'
         ),
         NavigationDestination(
           selectedIcon: Icon(Icons.person),
             icon: Icon(Icons.person_2_outlined),
             label: 'account'
         ),
       ],
selectedIndex: index,
       indicatorColor: Colors.deepPurple.shade200,
       onDestinationSelected: (value) {
    ref.read(navigationNotifierProvider.notifier).setSelectedIndex(value);
       },
     ),

    );
  }
}
