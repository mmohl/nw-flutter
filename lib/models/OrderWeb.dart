import 'dart:convert';

import 'package:nandjung_wangi_flutter/models/Order.dart';

class OrderWeb {
  String date;
  String id;
  String orderCode;
  String orderedBy;
  String tableNumber;
  List<Order> orders;

  OrderWeb.dataFromJson(Map response) {
    this.date = response['date'];
    this.orderedBy = response['ordered_by'];
    this.tableNumber = response['table_number'];
    this.id = response['id'];
    this.orderCode = response['order_code'];
    // return List<Data>.from(response['data'].map((data) => Data.fromJson(data)));
  }

  Map toJson() {
    List<Map> orders = this.orders != null
        ? this
            .orders
            .map((i) => {'id': i.item.id, 'qty': i.totalOrder})
            .toList()
        : null;

    return {"orderId": id, "items": orders};
  }
}
