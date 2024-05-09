import 'package:fast_notes/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const FastNotesApp());

class FastNotesApp extends StatelessWidget{
  @override
  const FastNotesApp({super.key});

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreenView(),
      routes: {
        "home" : (_) => const HomeScreenView()
      },
    );
  }
}