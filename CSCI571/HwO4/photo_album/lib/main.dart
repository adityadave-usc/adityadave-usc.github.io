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
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPage(),
        '/home': (context) => const HomePage(),
        '/image_viewer': (context) => ImageViewerPage(),
      },
    );
  }
}
