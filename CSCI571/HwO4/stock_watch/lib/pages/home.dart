import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_watch/models/stock.dart';
import 'package:stock_watch/widgets/dismissible_widget.dart';
import 'package:stock_watch/widgets/stock_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int dummyCounterForPageRefresh = 0;
  late Future<List<StockMeta>> stockWatchList;

  Future<List<StockMeta>> loadWatchList() async {
    final prefs = await SharedPreferences.getInstance();

    List<StockMeta> watchList = [];

    String? fromPrefs = prefs.getString('WATCH_LIST');

    if (fromPrefs != null) {
      List prefsWatchList = (jsonDecode(fromPrefs) as List);
      for (Map<String, dynamic> stockMetaMap in prefsWatchList) {
        watchList.add(StockMeta.fromJson(stockMetaMap));
      }
    }

    return watchList;
  }

  @override
  Widget build(BuildContext context) {
    stockWatchList = loadWatchList();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Stock',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4),
          ),
          actions: [
            IconButton(
              // padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 24.0,
              ),
              onPressed: () {
                showSearch(context: context, delegate: StockSearchDelegate())
                    .then((stock) => {
                          if (stock != null)
                            {
                              Navigator.pushNamed(context, '/stock_details',
                                      arguments: stock)
                                  .then(onGoBack)
                            }
                        });
              },
            )
          ],
        ),
        body: Container(
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
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'WATCH LIST',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      letterSpacing: 0.8, fontWeight: FontWeight.bold),
                ),
                const Divider(
                    height: 32.0, color: Colors.white, thickness: 1.0),
                FutureBuilder(
                    future: stockWatchList,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError || snapshot.data == null) {
                            return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                    child: Text(
                                  'Empty',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.bold),
                                )));
                          }
                          List<StockMeta> stockWatchList =
                              snapshot.data as List<StockMeta>;

                          if (stockWatchList.isEmpty) {
                            return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                    child: Text(
                                  'Empty',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.bold),
                                )));
                          }

                          return ListView.separated(
                            itemCount: stockWatchList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DismissibleWidget(
                                item: stockWatchList[index],
                                child: stockTile(stockWatchList[index]),
                                confirmDismissed: (DismissDirection direction) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Please Confirm',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.8,
                                              )),
                                          content: Text(
                                              'Are you sure, you want to remove ${stockWatchList[index].symbol} from favorites?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: const Text('Delete')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                                child: const Text('Cancel'))
                                          ],
                                        );
                                      });
                                },
                                onDismissed: (DismissDirection direction) {
                                  StockMeta stockToDelete =
                                      stockWatchList[index];
                                  setState(() {
                                    stockWatchList.removeAt(index);
                                    saveStockWatchList(stockWatchList);
                                  });
                                  SnackBar snackBar = SnackBar(
                                    content: Text(stockToDelete.symbol +
                                        ' removed from the watchlist'),
                                    duration: const Duration(milliseconds: 800),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              color: Colors.white,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          );
                      }
                    })
              ]),
        ));
  }

  Widget stockTile(StockMeta stock) {
    return TextButton(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.symbol,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                stock.description,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/stock_details', arguments: stock)
            .then(onGoBack);
      },
    );
  }

  void refreshData() {
    dummyCounterForPageRefresh++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() { });
  }

  void saveStockWatchList(List<StockMeta> stockWatchList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('WATCH_LIST', jsonEncode(stockWatchList));
    setState(() { });
  }
}
