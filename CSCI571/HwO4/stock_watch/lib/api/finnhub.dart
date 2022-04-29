import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stock_watch/models/stock.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinnhubAPI {

  static final String FINNHUB_URL = dotenv.env['FINNHUB_URL'] ?? '';

  static final String FINNHUB_KEY = dotenv.env['FINNHUB_KEY'] ?? '';

  static Future<List<StockMeta>> searchStocks({required String query}) async {
    final String url = '$FINNHUB_URL/search?q=$query&token=$FINNHUB_KEY';

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body['result'].map<StockMeta>((stockSearchData) {
      return StockMeta(
        description: stockSearchData['description'],
        displaySymbol: stockSearchData['displaySymbol'],
        symbol: stockSearchData['symbol'],
        type: stockSearchData['type'],
      );
    }).toList();
  }


  static Future<StockProfile?> getStockProfile({required String symbol}) async {
    final String url = '$FINNHUB_URL/stock/profile2?symbol=$symbol&token=$FINNHUB_KEY';

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    if(body.length == 0) {
      return null;
    }
    
    return StockProfile(
      country: body['country'],
      currency: body['currency'],
      exchange: body['exchange'],
      finnhubIndustry: body['finnhubIndustry'],
      ipo: body['ipo'],
      logo: body['logo'],
      marketCapitalization: body['marketCapitalization'],
      name: body['name'],
      phone: body['phone'],
      shareOutstanding: body['shareOutstanding'],
      ticker: body['ticker'],
      webUrl: body['weburl'],
    );
  }


  static Future<StockQuote?> getStockQuote({required String symbol}) async {
    final String url = '$FINNHUB_URL/quote?symbol=$symbol&token=$FINNHUB_KEY';

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    if(body.length == 0) {
      return null;
    }

    return StockQuote(
        current: body['c'].toDouble(),
        change: body['d'].toDouble(),
        percentChange: body['dp'].toDouble(),
        high: body['h'].toDouble(),
        low: body['l'].toDouble(),
        open: body['o'].toDouble(),
        prev: body['pc'].toDouble()
    );
  }

}