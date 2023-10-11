import 'package:farmwise/buyerScreens/data/cartData.dart';
import 'package:farmwise/buyerScreens/data/productList.dart';
import 'package:farmwise/buyerScreens/models/product.dart';
import 'package:farmwise/buyerScreens/widgets/CartItem.dart';
import 'package:farmwise/buyerScreens/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/buyerScreens/models/product.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<cartPage> {
  @override
  Widget build(BuildContext context) {
    final totalPrice = CartData.cartList.isEmpty
        ? 0
        : CartData.cartList
            .map((e) => e.price * e.quantity)
            .reduce((total, price) => total + price);

    return Scaffold(
        body: ListView(
      padding: EdgeInsets.all(16),
      children: [
        // list of cart items
        ...List.generate(CartData.cartList.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CartItem(
              cartItem: CartData.cartList[index],
            ),
          );
        }),
        SizedBox(
          height: 15,
        ),

        //total items in cart, total price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total (${CartData.cartList.length})"),
            Text(
              "\Rs.${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 85, 127, 83),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        SizedBox(height: 20),

        FilledButton.icon(
            onPressed: () {},
            icon: Icon(Icons.arrow_right),
            label: Text("Proceed to checkout"))
        //checkout button
      ],
    ));
  }
}
