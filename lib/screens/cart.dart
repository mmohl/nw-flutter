import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:nandjung_wangi_flutter/models/Order.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';

class Cart extends StatelessWidget {
  // Cart(this.Transaction);

  static String routeName = '/cart';

  // final Transaction Transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Keranjang"),
    ));
  }
}
