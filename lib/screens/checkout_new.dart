import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/models/NewOrder.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';
import 'package:nandjung_wangi_flutter/screens/order_tabs.dart';
import 'package:nandjung_wangi_flutter/services/ApiService.dart';
import 'package:provider/provider.dart';

class CheckoutNew extends StatelessWidget {
  static String routeName = '/checkout-new';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Transaction _transaction = Provider.of<Transaction>(context, listen: false);
    NewOrder order = NewOrder(orders: _transaction.listOrders);
    ApiService service = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Pemesan'),
      ),
      body: Builder(
          builder: (ctx) => Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nama Pemesan',
                            filled: true,
                            fillColor: Colors.grey,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 6.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            order.orderedBy = value;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType:
                              TextInputType.numberWithOptions(signed: false),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nomor Meja',
                            filled: true,
                            fillColor: Colors.grey,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 6.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Nomor meja boleh kosong';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            order.tableNumber = value;
                          },
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
                                    textColor: Colors.white,
                                    color: Colors.green,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();

                                        service
                                            .makeNewOrder(order)
                                            .then((message) => {
                                                  showSnackBar(ctx, message),
                                                  _transaction.clearOrder(),
                                                  (new Timer(
                                                      const Duration(
                                                          seconds: 3),
                                                      () => Navigator.of(
                                                              context)
                                                          .pushNamedAndRemoveUntil(
                                                              OrderTab
                                                                  .routeName,
                                                              (route) =>
                                                                  false)))
                                                });
                                      }

                                      // print(_formKey.currentContext);
                                    },
                                    child: Text('Buat Pesanan')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
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
