import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_watch/pages/home.dart';
import 'package:stock_watch/pages/loading.dart';
import 'package:stock_watch/pages/search.dart';
import 'package:stock_watch/pages/stock_details.dart';


void main() {
  runApp(const StockWatchApp());
}

class StockWatchApp extends StatelessWidget {
  const StockWatchApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stock Watch',
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(
          primaryColor: Colors.white
        ),
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
