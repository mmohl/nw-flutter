import 'package:flutter/foundation.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:nandjung_wangi_flutter/models/Order.dart';

class Transaction with ChangeNotifier {
  //Prototype get list data from json
  List<Order> _orders;

  List<Order> get listOrders => [..._orders];
  set listOrders(List<Order> val) {
    _orders = val;
    notifyListeners();
  }

  void addOrder({Data item, int totalOrder}) {
    _orders.add(Order(item: item, totalOrder: totalOrder));
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
