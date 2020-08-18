import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "localhost:8080";
  Client client = Client();

  Future<List<Data>> getMenus(String category) async {
    switch (category) {
      case 'paket':
        category = 'package';
        break;
      case 'makanan':
        category = 'food';
        break;
      case 'minuman':
        category = 'beverage';
        break;
      case 'lain - lain':
        category = 'others';
        break;
    }
    try {
      Uri uri = Uri.http("10.0.2.2:8080", '/menu/menu-items',
          {'page': '1', 'perPage': '10', 'category': category});
      // print(uri.toString());
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return dataFromJson(response.body);
      } else {
        print(response.body);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
