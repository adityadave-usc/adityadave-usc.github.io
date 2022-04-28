class StockMeta {
  final String description;
  final String displaySymbol;
  final String symbol;
  final String type;

  const StockMeta({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
    required this.type,
  });

  StockMeta.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        displaySymbol = json['displaySymbol'],
        symbol = json['symbol'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
    'description': description,
    'displaySymbol': displaySymbol,
    'symbol': symbol,
    'type': type,
  };

  @override
  String toString() {
    return 'StockMeta{description: $description, displaySymbol: $displaySymbol, symbol: $symbol, type: $type}';
  }
}

class StockProfile {
  final String country;
  final String currency;
  final String exchange;
  final String finnhubIndustry;
  final String ipo;
  final String logo;
  final double marketCapitalization;
  final String name;
  final String phone;
  final double shareOutstanding;
  final String ticker;
  final String webUrl;

  const StockProfile(
      {required this.country,
      required this.currency,
      required this.exchange,
      required this.finnhubIndustry,
      required this.ipo,
      required this.logo,
      required this.marketCapitalization,
      required this.name,
      required this.phone,
      required this.shareOutstanding,
      required this.ticker,
      required this.webUrl});

  @override
  String toString() {
    return 'Stock{country: $country, currency: $currency, exchange: $exchange, finnhubIndustry: $finnhubIndustry, ipo: $ipo, logo: $logo, marketCapitalization: $marketCapitalization, name: $name, phone: $phone, shareOutstanding: $shareOutstanding, ticker: $ticker, webUrl: $webUrl}';
  }
}

class StockQuote {
  final double current;
  final double change;
  final double percentChange;
  final double high;
  final double low;
  final double open;
  final double prev;

  const StockQuote({
    required this.current,
    required this.change,
    required this.percentChange,
    required this.high,
    required this.low,
    required this.open,
    required this.prev,
  });
}
