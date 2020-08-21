import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/models/OrderWeb.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';
import 'package:nandjung_wangi_flutter/screens/order_tabs.dart';
import 'package:nandjung_wangi_flutter/services/ApiService.dart';
import 'package:provider/provider.dart';

class CheckoutExist extends StatelessWidget {
  static String routeName = '/checkout-exist';

  @override
  Widget build(BuildContext context) {
    ApiService service = ApiService();

    return Scaffold(
        appBar: AppBar(
          title: Text('Informasi Pemesan'),
        ),
        body: Builder(
          builder: (ctx) => Padding(
            padding: EdgeInsets.all(5),
            child: FutureBuilder(
              future: service.getUnpaidOrderToday(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<OrderWeb>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "Something wrong with message: ${snapshot.error.toString()}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<OrderWeb> items = snapshot.data;
                  return _buildListView(ctx, items);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ));
  }

  Widget _buildListView(BuildContext context, List<OrderWeb> orders) {
    Transaction _transaction = Provider.of<Transaction>(context, listen: false);

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          onTap: () => {
            showSelectOrderDialog(context, orders[index]).then((value) => {
                  _transaction.clearOrder(),
                  showSnackBar(context, 'Berhasil Menambahkan item ke pesanan'),
                  (new Timer(
                      const Duration(seconds: 2),
                      () => Navigator.of(context).pushNamedAndRemoveUntil(
                          OrderTab.routeName, (route) => false)))
                }),
          },
          title: Text(orders[index].orderedBy),
          subtitle: Text(
            orders[index].orderCode,
            style: TextStyle(color: Colors.grey),
          ),
          leading: Text(
            orders[index].tableNumber,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      itemCount: orders.length,
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Tutup',
      onPressed: () {},
    ),
  );

  // Find the Scaffold in the widget tree and use
  // it to show a SnackBar.
  Scaffold.of(context).showSnackBar(snackBar);
}

Future<void> showSelectOrderDialog(BuildContext context, OrderWeb order) async {
  Transaction _transaction = Provider.of<Transaction>(context, listen: false);
  ApiService service = ApiService();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Tambahkan Menu'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  "Apakah anda yakin menambahkan menu ke pesanan atas nama ${order.orderedBy} ?"),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Tidak'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Iya'),
            color: Colors.green,
            onPressed: () {
              order.orders = _transaction.listOrders;
              service.addNewItemToOrder(order).then((message) => {
                    Navigator.of(context).pop(),
                  });
            },
          ),
        ],
      );
    },
  );
}
