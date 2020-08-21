import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:nandjung_wangi_flutter/screens/item_detail.dart';

class GridItem extends StatelessWidget {
  GridItem(this.item);

  final Data item;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).pushNamed(ItemDetail.routeName, arguments: item)
      },
      child: GridTile(
        child: Image.network(
          'http://192.168.0.100/images/${item.img}',
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );
  }
}
