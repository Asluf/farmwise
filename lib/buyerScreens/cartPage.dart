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
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    // Calculate the initial totalPrice
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    if (CartData.cartList.isNotEmpty) {
      totalPrice = CartData.cartList
          .map((e) => e.price * e.quantity)
          .reduce((total, price) => total + price);
    } else {
      totalPrice = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final totalPrice = CartData.cartList.isEmpty
    //     ? 0
    //     : CartData.cartList
    //         .map((e) => e.price * e.quantity)
    //         .reduce((total, price) => total + price);

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
          icon: Container(
            color: Colors.green.shade600, // Set the color for the icon
            child: Icon(Icons.arrow_right,
                color: Colors.white), // Set the icon color
          ),
          label: Text("Proceed to checkout"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context)
                .primaryColor), // Set the background color to the theme's primary color
          ),
        )
        //checkout button
      ],
    ));
  }
}
