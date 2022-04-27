import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:stock_watch/models/stock.dart';
import 'package:stock_watch/widgets/dismissible_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Stock> stockWatchlist = <Stock>[
    const Stock(name: 'Name 01', ticker: 'Ticker 01'),
    const Stock(name: 'Name 02', ticker: 'Ticker 02')
  ];

  @override
  Widget build(BuildContext context) {
    // Load String of Tickers

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
                Navigator.pushNamed(context, "/search");
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
                              fontWeight: FontWeight.bold, letterSpacing: 1.0))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Watch List',
                textAlign: TextAlign.start,
                style:
                    TextStyle(letterSpacing: 0.8, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32.0, color: Colors.white, thickness: 1.0),
              stockWatchlist.isEmpty
                  ? const Center(
                      child: Text(
                      'Empty',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 4.0,
                          letterSpacing: 1.0,
                          fontSize: 24.0),
                    ))
                  : Expanded(
                      child: ListView.separated(
                      itemCount: stockWatchlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DismissibleWidget(
                          item: stockWatchlist[index],
                          child: stockTile(stockWatchlist[index]),
                          confirmDismissed: (DismissDirection direction) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Please Confirm', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8,)),
                                    content: const Text(
                                        'Are you sure, you want to remove item_name from favorites?'),
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
                            setState(() {
                              stockWatchlist.removeAt(index);
                            });
                            const SnackBar snackBar = SnackBar(
                              content: Text('AMZN removed from the watchlist'),
                              duration: Duration(milliseconds: 800),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                        );
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

  Widget stockTile(Stock stock) {
    return TextButton(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                stock.ticker,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                stock.name,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/stock_details');
      },
    );
  }
}
