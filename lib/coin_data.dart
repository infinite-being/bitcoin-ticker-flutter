import 'dart:convert';
import 'package:http/http.dart';

// https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd

const coingeckoURL = 'https://api.coingecko.com/api/v3/simple/price';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'Bitcoin',
  'Ethereum',
  'Litecoin',
];

class CoinData {
  Future getCoinData(String currency) async {
    List<int> cryptoPrices = List();
    for (String blockChain in cryptoList) {
      Response response =
          await get('$coingeckoURL?ids=$blockChain&vs_currencies=$currency');
      if (response.statusCode == 200) {
        cryptoPrices.add((jsonDecode(response.body)[blockChain.toLowerCase()]
                ['$currency'])
            .round());
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
