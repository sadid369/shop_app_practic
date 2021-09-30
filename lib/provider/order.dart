import 'package:flutter/material.dart';

import 'package:shop_app_practic/provider/cart.dart';

class OrderItem {
  final String id;
  final List<CartItem> cartItems;
  final DateTime dateTime;
  final double amount;
  OrderItem({
    required this.id,
    required this.cartItems,
    required this.dateTime,
    required this.amount,
  });
}

class Order with ChangeNotifier {
  final List<OrderItem> _orderItems = [];
  List<OrderItem> get orderItems {
    return [..._orderItems];
  }

  void addItems(List<CartItem> cartItem, double amount) {
    _orderItems.insert(
        0,
        OrderItem(
            amount: amount,
            id: DateTime.now().toString(),
            dateTime: DateTime.now(),
            cartItems: cartItem));
    notifyListeners();
  }
}
