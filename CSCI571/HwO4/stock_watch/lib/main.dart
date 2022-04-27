import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:stock_watch/pages/home.dart';
import 'package:stock_watch/pages/loading.dart';
import 'package:stock_watch/pages/search.dart';
import 'package:stock_watch/pages/stock_details.dart';


void main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(const StockWatchApp());
}

class StockWatchApp extends StatelessWidget {
  const StockWatchApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;

    return MaterialApp(
      title: 'Stock Watch',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white),
          toolbarTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const LoadingPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/search': (BuildContext context) => const SearchPage(),
        '/stock_details': (BuildContext context) => const StockDetails()
      },
    );
  }
}
