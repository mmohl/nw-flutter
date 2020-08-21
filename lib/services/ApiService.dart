import 'dart:convert';

import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:http/http.dart' show Client;
import 'package:nandjung_wangi_flutter/models/NewOrder.dart';
import 'package:nandjung_wangi_flutter/models/OrderWeb.dart';

class ApiService {
  final String baseUrl = "192.168.0.100";
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
      Uri uri = Uri.http(baseUrl, '/menu/menu-items',
          {'page': '1', 'perPage': '50', 'category': category});

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

  Future<String> makeNewOrder(NewOrder newOrder) async {
    Uri uri = Uri.http(baseUrl, '/transaction/make-order');

    try {
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(newOrder.toJson()));

      var bodyDecode = jsonDecode(response.body);
      return bodyDecode['message'];
      // if (response.statusCode >= 200) {
      // } else if (response.statusCode >= 300) {
      //   print(response.body);
      // }
    } catch (e) {
      print(e);
      return 'Gagal Membuat pesanan';
    }
  }

  Future<List<OrderWeb>> getUnpaidOrderToday() async {
    Uri uri = Uri.http(baseUrl, '/transaction/unfinished-order-today');

    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var unpaidOrders = jsonDecode(response.body);
      return List<OrderWeb>.from(
          unpaidOrders.map((o) => OrderWeb.dataFromJson(o)));
    } else {
      print(response.body);
      return [];
    }
    // try {
    // } catch (e) {
    //   print(e);
    //   return [];
    // }
  }

  Future<String> addNewItemToOrder(OrderWeb order) async {
    Uri uri = Uri.http(baseUrl, '/transaction/add-new-items-order');

    try {
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(order.toJson()));

      var bodyDecode = jsonDecode(response.body);
      return bodyDecode['message'];
      // if (response.statusCode >= 200) {
      // } else if (response.statusCode >= 300) {
      //   print(response.body);
      // }
    } catch (e) {
      print(e);
      return 'Gagal Membuat pesanan';
    }
  }
}
