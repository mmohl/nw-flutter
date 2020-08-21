import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatelessWidget {
  static String routeName = '/item-detail';

  @override
  Widget build(BuildContext context) {
    final orderInputController = TextEditingController();
    final item = ModalRoute.of(context).settings.arguments as Data;

    Transaction _transaction = Provider.of<Transaction>(context);

    orderInputController.text = '1';

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Builder(
          builder: (ctx) => Padding(
                padding: EdgeInsets.only(top: 3, left: 3, right: 3, bottom: 3),
                child: Card(
                  // color: Colors.green,
                  child: Column(
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeJdFAv-yuL608hmTmtZ6o9eUjTwzCA-u9ZQOnzqvONNxMhACX&s',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      ListTile(
                        // leading: Icon(Icons.album),
                        title: Text(FlutterMoneyFormatter(
                                settings: MoneyFormatterSettings(
                                    symbol: 'Rp',
                                    decimalSeparator: ',',
                                    thousandSeparator: '.'),
                                amount: item.price.roundToDouble())
                            .output
                            .symbolOnLeft),
                        subtitle: Text(
                          item.description != null ? item.description : '-',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              FlatButton(
                                color: Colors.red,
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 28),
                                ),
                                onPressed: () {
                                  int currentTotal =
                                      int.parse(orderInputController.text);

                                  if (currentTotal > 0) {
                                    currentTotal -= 1;
                                    orderInputController.text =
                                        currentTotal.toString();
                                  }
                                },
                              ),
                              FlatButton(
                                color: Colors.green,
                                child: Icon(Icons.add),
                                onPressed: () {
                                  int currentTotal =
                                      int.parse(orderInputController.text);

                                  currentTotal += 1;
                                  orderInputController.text =
                                      currentTotal.toString();
                                },
                              ),
                            ],
                          ),
                          Flexible(
                              child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                              width: 100,
                              height: 37,
                              child: TextField(
                                controller: orderInputController,
                                enabled: false,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ))
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              child: MaterialButton(
                                color: Colors.green,
                                onPressed: () {
                                  int total =
                                      int.parse(orderInputController.text);

                                  String message = 'Berhasil menambahkan item';
                                  if (total == 0) {
                                    message = 'Minimal item harus 1';
                                  } else if (total > 0) {
                                    _transaction.addOrder(
                                        item: item, totalOrder: total);
                                  }

                                  showSnackBar(ctx, message);
                                },
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  semanticLabel: 'Tambah',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
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
