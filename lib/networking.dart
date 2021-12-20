import 'dart:convert';

import 'package:http/http.dart' as HTTP;

String apiKey1 = '002792C3-E3A0-491B-8057-8FC260D91320';
String apiKey2 = 'F9A2A3A7-F235-4FDD-8AA1-D4355C0DC0A3';
String apiKey3 = '40E3F175-3629-4FB2-AF90-2EA2C990041E';

String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=';

class Networking {
  getData(String coin) async {
    if (coin != 'EGP') {
      HTTP.Response response = await HTTP.get(
          'https://rest.coinapi.io/v1/exchangerate/BTC/$coin?apikey=$apiKey3');
      String body = response.body;
      if (response.statusCode == 200) {
        dynamic rate = await jsonDecode(body)['rate'];
        int rateInt = rate.toInt();
        return rateInt;
      } else {
        print(response.statusCode);
      }
    } else if (coin == 'EGP') {
      HTTP.Response response = await HTTP.get(
          'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$apiKey3');
      String body = response.body;
      if (response.statusCode == 200) {
        dynamic rate = await jsonDecode(body)['rate'];
        double rateInt = rate * 15.64;
        return rateInt.toInt();
      } else {
        print(response.statusCode);
      }
    }
  }
}
