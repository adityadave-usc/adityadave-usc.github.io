import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> favorites = <String>[/*'Sample 01', 'Sample 02'*/];

  @override
  Widget build(BuildContext context) {
    // Load String of Tickers

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.purple,
          middle: const Text(
            'Stock',
            style: TextStyle(letterSpacing: 0.4),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.white,
              size: 18.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'STOCK WATCH',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      ),
                      Text(DateFormat('MMMM d').format(DateTime.now()),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.0))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Favorites',
                textAlign: TextAlign.start,
                style:
                    TextStyle(letterSpacing: 0.8, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32.0, color: Colors.white, thickness: 1.0),
              // ListView.builder(itemBuilder: (itemBuilder),
              favorites.isEmpty
                  ? const Center(
                      child: Text(
                      'Empty',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 4.0,
                          letterSpacing: 1.0, fontSize: 24.0),
                    ))
                  : Expanded(
                      child: ListView.separated(
                      itemCount: favorites.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin:
                                const EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 4.0),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        favorites[index],
                                        style: const TextStyle(fontSize: 18.0, color: Colors.white),
                                      ),
                                      Text(
                                        favorites[index],
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/stock_details');
                              },
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Colors.white,
                      ),
                    ))
            ],
          ),
        ));
  }
}
