import 'dart:math';

import 'package:farmwise/buyerScreens/data/productList.dart';
import 'package:farmwise/buyerScreens/models/order.dart';
import 'package:farmwise/buyerScreens/models/product.dart';
import 'package:farmwise/buyerScreens/orderDetailsPage.dart';
import 'package:flutter/material.dart';

class OrderProduct extends StatelessWidget {
  OrderProduct({super.key, required this.Order, required this.Product});
  final order Order;
  final product Product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => orderDetailsPage(Order: Order)));
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 90,
            margin: EdgeInsets.only(right: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Product.image),
                )),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 177, 109),
                    fontSize: 17,
                  ),
                ),
                Text(
                  Product.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 14, 14, 14),
                    fontSize: 12,
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs.${Product.price}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Qty : ${Random().nextInt(4) + 1}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
