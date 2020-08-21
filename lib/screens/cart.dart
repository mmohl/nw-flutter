import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nandjung_wangi_flutter/models/Order.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';
import 'package:nandjung_wangi_flutter/screens/checkout_exist.dart';
import 'package:nandjung_wangi_flutter/screens/checkout_new.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  // Cart(this.Transaction);

  static String routeName = '/cart';

  // final Transaction Transaction;

  @override
  Widget build(BuildContext context) {
    Transaction _transaction = Provider.of<Transaction>(context);
    List<Order> orders = _transaction.listOrders;
    int total = 0;
    double tax = 0;

    orders.forEach((e) {
      total += e.totalOrder * e.item.price;
    });

    tax = total * 0.10;

    return Scaffold(
      appBar: AppBar(title: Text("Keranjang")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              height: 475,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (BuildContext ctx, int index) => Card(
                        child: ListTile(
                          onLongPress: () =>
                              {showRemoveItemDialog(context, orders[index])},
                          // isThreeLine: true,
                          leading: Image.network(
                            "http://192.168.0.100/images/${orders[index].item.img}",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          title: Text(orders[index].item.name),
                          subtitle: Text(
                            "${orders[index].totalOrder} X ${FlutterMoneyFormatter(settings: MoneyFormatterSettings(symbol: 'Rp', decimalSeparator: ',', thousandSeparator: '.'), amount: orders[index].item.price.toDouble()).output.symbolOnLeft}",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )),
            ),
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              color: Colors.green,
              height: 30,
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                FlutterMoneyFormatter(
                            settings: MoneyFormatterSettings(
                                symbol: 'Rp',
                                decimalSeparator: ',',
                                thousandSeparator: '.'),
                            amount: total.toDouble() + tax)
                        .output
                        .symbolOnLeft +
                    " (Pajak 10%)",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: SpeedDial(
        visible: total > 0,
        overlayColor: Colors.grey[300],
        backgroundColor: Colors.green[200],
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.mode_edit),
              label: 'Tambah ke order lama',
              onTap: () =>
                  {Navigator.of(context).pushNamed(CheckoutExist.routeName)}),
          SpeedDialChild(
              child: Icon(Icons.add),
              label: 'Buat order baru',
              onTap: () =>
                  {Navigator.of(context).pushNamed(CheckoutNew.routeName)})
        ],
      ),
    );
  }
}

Future<void> showRemoveItemDialog(BuildContext context, Order order) async {
  Transaction _transaction = Provider.of<Transaction>(context, listen: false);

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus dari keranjang'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  "Apakah anda yakin ingin menghapus ${order.item.name} dari keranjang?"),
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
              _transaction.deleteOrder(order.item);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
