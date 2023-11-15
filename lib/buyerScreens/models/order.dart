import 'package:farmwise/buyerScreens/models/product.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/utils/enums/order.dart';

class order {
  final String id;
  final List<product> products;
  final DateTime orderingDate;
  final DateTime deliveryDate;
  final OrderStatus status;

  const order({
    required this.id,
    required this.products,
    required this.orderingDate,
    required this.deliveryDate,
    required this.status,
  });
}
