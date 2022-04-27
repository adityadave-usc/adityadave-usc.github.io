import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class StockDetails extends StatefulWidget {
  const StockDetails({Key? key}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    // Get stock details from Ticker

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
                  isFavorite ? Icons.star : Icons.star_border_outlined,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;

                    SnackBar snackBar;
                    if (isFavorite) {
                      snackBar = const SnackBar(
                        content: Text('AMZN added to the wishlist'),
                        duration: Duration(milliseconds: 800),
                      );
                    } else {
                      snackBar = const SnackBar(
                        content: Text('AMZN removed from the watchlist'),
                        duration: Duration(milliseconds: 800),
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: const [
                Text(
                  'AMZN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      letterSpacing: 0.4),
                ),
                SizedBox(width: 12.0),
                Text('Amazon.com Inc',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 24.0, letterSpacing: 0.4))
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text('3055.7',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        letterSpacing: 0.4)),
                const SizedBox(
                  width: 12.0,
                ),
                Text('+21.57',
                    style: TextStyle(
                        color:
                            '+21.57'.contains('+') ? Colors.green : Colors.red,
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
                  children: const [
                    Expanded(
                      child: Text('Open'),
                    ),
                    Expanded(
                        child: Text(
                      '2548.2',
                      style: TextStyle(color: Colors.grey),
                    )),
                    Expanded(
                      child: Text('High'),
                    ),
                    Expanded(
                        child: Text(
                      '2574.24',
                      style: TextStyle(color: Colors.grey),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text('Low'),
                    ),
                    Expanded(
                        child: Text(
                      '3006',
                      style: TextStyle(color: Colors.grey),
                    )),
                    Expanded(
                      child: Text('Prev'),
                    ),
                    Expanded(
                        child: Text(
                      '3034.13',
                      style: TextStyle(color: Colors.grey),
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
                  children: const [
                    Expanded(
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
                        '2004-08-19',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Industry',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                        flex: 8,
                        child: Text(
                          'Media',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ))
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          flex: 4,
                          child: Text(
                            'Website',
                            style: TextStyle(fontSize: 14.0),
                          )),
                      Expanded(
                          flex: 8,
                          child: Text.rich(TextSpan(
                              text: 'https://www.google.com',
                              style: const TextStyle(
                                  fontSize: 14.0, color: Colors.blue),
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
                    const Expanded(
                      flex: 8,
                      child: Text(
                        'Global Market',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Market Cap',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        '1678600',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    )
                  ],
                )
              ],
            )
          ]),
        ));
  }
}
