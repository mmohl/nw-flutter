import 'package:flutter/foundation.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:nandjung_wangi_flutter/models/Order.dart';

class Transaction with ChangeNotifier {
  //Prototype get list data from json
  List<Order> _orders = [];

  List<Order> get listOrders => [..._orders];
  set listOrders(List<Order> val) {
    _orders = val;
    notifyListeners();
  }

  void addOrder({Data item, int totalOrder}) {
    if (_orders.length == 0) {
      _orders.add(Order(item: item, totalOrder: totalOrder));
    } else if (_orders.length > 0) {
      Order existing =
          _orders.firstWhere((e) => e.item.id == item.id, orElse: () => null);
      if (existing != null) {
        _orders.forEach((e) {
          if (e.item.id == item.id) {
            e.totalOrder += totalOrder;
          }
        });
      } else {
        _orders.add(Order(item: item, totalOrder: totalOrder));
      }
    }
    notifyListeners();
  }

  void clearOrder() {
    _orders = [];
    notifyListeners();
  }

  void updateOrder({Data item, int totalOrder}) {
    Order filteredOrder = _orders.singleWhere((el) => el.item.id == item.id);
    filteredOrder.totalOrder = totalOrder;
    notifyListeners();
  }

  void deleteOrder(Data item) {
    _orders.removeWhere((el) => el.item.id == item.id);
    notifyListeners();
  }
}
