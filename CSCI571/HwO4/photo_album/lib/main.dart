import 'package:album_571/pages/home.dart';
import 'package:album_571/pages/image_viewer.dart';
import 'package:album_571/pages/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Album597());
}

class Album597 extends StatelessWidget {
  const Album597({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album 597',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/home': (context) => HomePage(),
        '/image_viewer': (context) => ImageViewerPage(),
      },
    );
  }
}
