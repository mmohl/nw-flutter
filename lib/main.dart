import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/screens/cart.dart';
import 'package:nandjung_wangi_flutter/screens/checkout_exist.dart';
import 'package:nandjung_wangi_flutter/screens/checkout_new.dart';
import 'package:nandjung_wangi_flutter/screens/item_detail.dart';
import 'package:nandjung_wangi_flutter/screens/order_tabs.dart';
import 'package:provider/provider.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Transaction(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nandjung Wangi',
          theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Montserrat'),
          // home: MyHomePage(title: 'Nandjung Wangi'),
          initialRoute: OrderTab.routeName,
          routes: {
            Cart.routeName: (context) => Cart(),
            ItemDetail.routeName: (context) => ItemDetail(),
            CheckoutNew.routeName: (context) => CheckoutNew(),
            CheckoutExist.routeName: (context) => CheckoutExist(),
            OrderTab.routeName: (context) => OrderTab(),
          },
        ));
  }
}
