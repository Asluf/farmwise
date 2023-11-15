import 'package:farmwise/buyerScreens/data/orderList.dart';
import 'package:farmwise/buyerScreens/data/orderList.dart';
import 'package:farmwise/buyerScreens/data/productList.dart';

import 'package:farmwise/buyerScreens/models/order.dart';
import 'package:farmwise/buyerScreens/widgets/orderProduct.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {super.key, required this.Order, required this.visibleProducts});
  final order Order;
  final int visibleProducts;

  @override
  Widget build(BuildContext context) {
    final totalPrice = Order.products.fold(0.0, (acc, e) => acc + e.price);
    final products = Order.products.take(2).toList();
    return Card(
      clipBehavior: Clip.antiAlias, //clip the edges
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          width: 0.2,
          color: Colors.grey,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Order : ${Order.id}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "(${Order.products.length} Items)",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Rs.${totalPrice.toStringAsFixed(2)}")
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ...List.generate(products.length, (index) {
              return OrderProduct(Order: Order, Product: products[index]);
            }),
            if (Order.products.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView.builder(
                                  itemCount: Order.products.length,
                                  padding: EdgeInsets.all(14),
                                  itemBuilder: (context, index) {
                                    final product = Order.products[index];
                                    return OrderProduct(
                                        Order: Order, Product: product);
                                  }),
                            );
                          });
                    },
                    icon: Icon(Icons.arrow_downward,
                        color: Colors.green.shade600),
                    label: Text("View all",
                        style: TextStyle(color: Colors.green.shade600))),
              )
          ],
        ),
      ),
    );
  }
}
