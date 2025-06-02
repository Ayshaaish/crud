import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LightAndDarkMode extends ConsumerWidget {
  const LightAndDarkMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    final isLightTheme=ref.watch(themeProvider);
    return MaterialApp(
      title: 'theme',
      theme: isLightTheme?ThemeData.light():ThemeData.dark(),
        home: MyHomePage(),
    );
  }
}
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});
  @override
  Widget build(Object context, WidgetRef ref){
    final isLightTheme=ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: Center(
        child:Switch(
            value: isLightTheme,
            onChanged: (value) => ref.read(themeProvider.notifier).state=value,
        ),
      ),
    );
  }
}
