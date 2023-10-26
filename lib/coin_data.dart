import 'package:http/http.dart' as http;
import 'dart:convert';

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
  'ZAR',
  'TRY',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'your api key here';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    final Uri baseAPIURL = Uri(
      scheme: 'https',
      host: 'rest.coinapi.io',
      path: 'v1/exchangerate/BTC/$selectedCurrency', // Replace this with your desired path
      queryParameters: {
        'apikey': apiKey,
      },
    );

    final Uri requestURL = baseAPIURL;

    print(requestURL);
    http.Response response = await http.get(requestURL);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
