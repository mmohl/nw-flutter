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
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeJdFAv-yuL608hmTmtZ6o9eUjTwzCA-u9ZQOnzqvONNxMhACX&s',
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            item.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
