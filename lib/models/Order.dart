// import 'dart:convert';

import 'package:nandjung_wangi_flutter/models/Data.dart';

class Order {
  Data item;
  int totalOrder;

  Order({this.item, this.totalOrder});

  // factory Order.fromJson(Map<String, dynamic> data) {
  //   return Order(
  //       id: data['id'],
  //       name: data['name'],
  //       category: data['category'],
  //       price: data['price'],
  //       img: data['img']);
  // }

  // Map<String, String> toJson() {
  //   return {
  //     "id": "$id",
  //     "name": name,
  //     "category": category,
  //     "price": "$price",
  //     img: img
  //   };
  // }

  @override
  String toString() {
    return 'Order{data: $item, totalOrder: $totalOrder}';
  }
}

// List<Order> dataFromJson(String jsonData) {
//   final response = json.decode(jsonData);
//   return List<Order>.from(response['data'].map((data) => Order.fromJson(data)));
// }

// String dataToJson(Order data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
// }
