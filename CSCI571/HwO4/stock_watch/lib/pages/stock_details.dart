import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stock_watch/api/finnhub.dart';
import 'package:stock_watch/models/stock.dart';

class StockDetailsPage extends StatefulWidget {
  const StockDetailsPage({Key? key}) : super(key: key);

  @override
  State<StockDetailsPage> createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  // Todo: Remove watch list button if Failed to fetch data
  bool isWatchListed = false;
  
  late StockMeta stockToShow;
  final numberFormatter = NumberFormat('###.0#');

  @override
  Widget build(BuildContext context) {
    // Get stock details from Ticker
    stockToShow =
        ModalRoute.of(context)?.settings.arguments as StockMeta;

    numberFormatter.minimumFractionDigits = 2;
    numberFormatter.minimumIntegerDigits = 1;

    // Load watch list



    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Details',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isWatchListed ? Icons.star : Icons.star_border_outlined,
                ),
                onPressed: () {
                  setState(() {
                    isWatchListed = !isWatchListed;

                    SnackBar snackBar;
                    if (isWatchListed) {
                      addStockToWatchList(stockToShow);
                      snackBar = SnackBar(
                        content: Text(stockToShow.symbol + ' added to the wishlist'),
                        duration: const Duration(milliseconds: 800),
                      );
                    } else {
                      removeStockFromWatchList(stockToShow);
                      snackBar = SnackBar(
                        content: Text(stockToShow.symbol + ' removed from the watchlist'),
                        duration: const Duration(milliseconds: 800),
                      );
                    }

                    // Show the SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
              ),
            ]),
        body: Container(
            margin: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: Future.wait([
                FinnhubAPI.getStockProfile(symbol: stockToShow.symbol),
                FinnhubAPI.getStockQuote(symbol: stockToShow.symbol)
              ]),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return failedToFetchData();
                    } else {
                      var responses = snapshot.data! as List;
                      StockProfile stockProfile = responses[0];
                      StockQuote stockQuote = responses[1];
                      return showStockDetails(
                          stockMeta: stockToShow,
                          stockProfile: stockProfile,
                          stockQuote: stockQuote);
                    }
                }
              },
            )));
  }

  Widget failedToFetchData() {
    return const Center(
        child: Text(
      'Failed to fetch stock data!',
      style: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, letterSpacing: 0.8),
    ));
  }

  Widget showStockDetails(
      {required StockMeta stockMeta,
      required StockProfile stockProfile,
      required StockQuote stockQuote}) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.all(32.0),
        child: Center(child: Image.network(stockProfile.logo)),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            stockMeta.symbol,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                letterSpacing: 0.4),
          ),
          const SizedBox(width: 12.0),
          Text(stockMeta.description,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 18.0, letterSpacing: 0.4))
        ],
      ),
      const SizedBox(height: 8.0),
      Row(
        children: [
          Text(numberFormatter.format(stockQuote.current),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.4)),
          const SizedBox(
            width: 12.0,
          ),
          Text(NumberFormat('+ 0.00 ;- ').format(stockQuote.change),
              style: TextStyle(
                  color:
                      stockQuote.change > 0 ? Colors.green : Colors.red,
                  fontSize: 22.0,
                  letterSpacing: 0.4)),
        ],
      ),
      const SizedBox(height: 16.0),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stats',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text('Open'),
              ),
              Expanded(
                  child: Text(
                numberFormatter.format(stockQuote.open),
                style: const TextStyle(color: Colors.grey),
              )),
              const Expanded(
                child: Text('High'),
              ),
              Expanded(
                  child: Text(
                numberFormatter.format(stockQuote.high),
                style: const TextStyle(color: Colors.grey),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text('Low'),
              ),
              Expanded(
                  child: Text(
                numberFormatter.format(stockQuote.low),
                style: const TextStyle(color: Colors.grey),
              )),
              const Expanded(
                child: Text('Prev'),
              ),
              Expanded(
                  child: Text(
                numberFormatter.format(stockQuote.prev),
                style: const TextStyle(color: Colors.grey),
              ))
            ],
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  flex: 4,
                  child: Text(
                    'Start Date',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  )),
              Expanded(
                flex: 8,
                child: Text(
                  stockProfile.ipo,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 4,
                child: Text(
                  'Industry',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Text(
                    stockProfile.finnhubIndustry,
                    style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                  ))
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Expanded(
                flex: 4,
                child: Text(
                  'Website',
                  style: TextStyle(fontSize: 14.0),
                )),
            Expanded(
                flex: 8,
                child: Text.rich(TextSpan(
                    text: stockProfile.webUrl,
                    style: const TextStyle(fontSize: 14.0, color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse('https://www.google.com'),
                            mode: LaunchMode.externalApplication);
                      })))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Exchange',
                        style: TextStyle(fontSize: 14.0),
                      )
                    ]),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  stockProfile.exchange,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 4,
                child: Text(
                  'Market Cap',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  stockProfile.marketCapitalization.toString(),
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              )
            ],
          )
        ],
      )
    ]);
  }

  void addStockToWatchList(StockMeta stockMeta) async {
    final prefs = await SharedPreferences.getInstance();

    List previousWatchList = [];
    String? fromPrefs = prefs.getString('WATCH_LIST');
    if (fromPrefs != null) {
      List prefsWatchList = (jsonDecode(fromPrefs) as List);
      previousWatchList = [ ...prefsWatchList ];
    }
    previousWatchList.add(jsonEncode(stockToShow));

    prefs.setString('WATCH_LIST', jsonEncode(previousWatchList));
  }

  void removeStockFromWatchList(StockMeta stockMeta) async {
    final prefs = await SharedPreferences.getInstance();

    List previousWatchList = [];
    String? fromPrefs = prefs.getString('WATCH_LIST');
    if (fromPrefs != null) {
      List prefsWatchList = (jsonDecode(fromPrefs) as List);
      previousWatchList = [ ...prefsWatchList ];
    }

    previousWatchList.remove(stockMeta);

    prefs.setString('WATCH_LIST', jsonEncode(previousWatchList));
  }
}
