import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:http/http.dart' show Client;

class ApiService {

  final String baseUrl = "https://api.icndb.com";
  Client client = Client();

  Future<List<Data>> getProfiles() async {
    final response = await client.get("$baseUrl/jokes/random/5");
    if (response.statusCode == 200) {
      return dataFromJson(response.body);
    } else {
      return null;
    }
  }

}