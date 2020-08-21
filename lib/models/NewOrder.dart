import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/models/Order.dart';
import 'package:flutter/foundation.dart';

class NewOrder {
  String orderedBy;
  String tableNumber;
  List<Order> orders;

  NewOrder({orderedBy, this.tableNumber, @required this.orders});

  // Map<String, dynamic> toJson() {
  //   print(orders);
  //   return {
  //     "orderedBy": orderedBy,
  //     "tableNumber": tableNumber,
  //     "orders": "[" +
  //         [...orders]
  //             .map((e) => {"id": e.item.id, "qty": e.totalOrder})
  //             .toString() +
  //         "]"
  //   };
  // }

  Map toJson() {
    List<Map> orders = this.orders != null
        ? this
            .orders
            .map((i) => {'id': i.item.id, 'qty': i.totalOrder})
            .toList()
        : null;

    return {
      "orderedBy": orderedBy,
      "tableNumber": tableNumber,
      "items": orders
    };
  }
}
