import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future requestData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  static const coinioApiKey = 'C5AF6908-EC51-407A-8D6B-852B64BAF99C';
  static const coinioKeyHeaderName = 'X-CoinAPI-Key';

  Future requestCoinData(String currencyOne, String currencyTwo) async {
    String coinioURL = '$url/$currencyOne/$currencyTwo';

    http.Response response = await http.get(Uri.parse(coinioURL), headers: {
      coinioKeyHeaderName: coinioApiKey,
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      // print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
