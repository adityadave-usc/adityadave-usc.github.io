import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> suggestions = <String>[
    // 'Suggestion 01 | Suggest 01',
    // 'Suggestion 02 | Suggest 01'
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Colors.black,
          middle: CupertinoSearchTextField(
            padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
            placeholder: 'Search',
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            autofocus: true,
          ),
        ),
        child: Container(
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
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          suggestions[index],
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
