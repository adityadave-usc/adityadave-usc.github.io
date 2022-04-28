import 'package:flutter/material.dart';
import 'package:stock_watch/api/finnhub.dart';
import 'package:stock_watch/models/stock.dart';
import 'package:stock_watch/pages/stock_details.dart';

class StockSearchDelegate extends SearchDelegate<StockMeta?> {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              }
              query = '';
            },
            icon: const Icon(Icons.clear)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => const StockDetailsPage();

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<StockMeta>>(
          future: FinnhubAPI.searchStocks(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data ?? []);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => const Center(
      child: Text('No Suggestions Found!',
          style: TextStyle(color: Colors.white, letterSpacing: 0.8)));

  Widget buildSuggestionsSuccess(List<StockMeta> suggestions) {
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                suggestions[index].symbol.toUpperCase() +
                    ' | ' +
                    suggestions[index].description.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Colors.white),
              ),
              onPressed: () => close(context, suggestions[index]),
            ),
          );
        });
  }
}
