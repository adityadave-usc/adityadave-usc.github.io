import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final String FINNHUB_URL = dotenv.env['FINNHUB_URL'] ?? '';

  final String FINNHUB_KEY = dotenv.env['FINNHUB_KEY'] ?? '';

  final List<String> suggestions = <String>[
    'Suggestion 01 | Suggest 01',
    'Suggestion 02 | Suggest 01'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextField(
            autofocus: true,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: suggestions.isEmpty
              ? const Center(
                  child: Text(
                  'No Suggestions Found!',
                  style: TextStyle(letterSpacing: 0.8, fontSize: 24.0),
                ))
              : ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                      child: TextButton(
                        child: Text(
                          suggestions[index],
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 0.8, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/stock_details');
                        },
                      ),
                    );
                  }),
        ));
  }
}
