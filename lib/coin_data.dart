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
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String blockChain, String currency) async {
    Response response =
        await get('$coingeckoURL?ids=$blockChain&vs_currencies=$currency');
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['$blockChain']['$currency'];
    } else {
      print(response.statusCode);
    }
  }
}
