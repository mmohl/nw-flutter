import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';

class ItemDetail extends StatelessWidget {
  static String routeName = '/item-detail';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context).settings.arguments as Data;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(3),
        child: Card(
          color: Colors.green,
          child: Column(
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeJdFAv-yuL608hmTmtZ6o9eUjTwzCA-u9ZQOnzqvONNxMhACX&s',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListTile(
                // leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text(item.price.toString()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.indigo,
                        child: const Text('-'),
                        onPressed: () {/* ... */},
                      ),
                      FlatButton(
                        color: Colors.indigo,
                        child: const Text('+'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      width: 50,
                      height: 37,
                      child: TextField(
                        enabled: false,
                        enableSuggestions: false,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
