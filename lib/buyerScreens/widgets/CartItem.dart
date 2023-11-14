import 'dart:async';

//import 'package:farmwise/buyerScreens/data/cartData.dart';
import 'package:farmwise/buyerScreens/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartItem});

  final product cartItem;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final product cartItem = widget.cartItem;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(10)),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        final completer = Completer<bool>();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text("Remove from Cart ? "),
          action: SnackBarAction(
              label: "Keep",
              onPressed: () {
                //keep the value
                completer.complete(false);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }),
        ));
        Timer(Duration(seconds: 3), () {
          if (!completer.isCompleted) {
            completer.complete(true);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        });

        return await completer.future;
      }, //unique number for every card
      child: SizedBox(
          height: 120,
          child: Card(
            clipBehavior: Clip.antiAlias, //clip the edges
            elevation: 0.1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                width: 0.2,
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  //image
                  Container(
                    width: 90,
                    height: double.infinity,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(cartItem.image),
                        )),
                  ),
                  //other information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.name,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          cartItem.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs.${cartItem.price}.00",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 99, 162, 96)),
                            ),
                            SizedBox(
                              height: 30,
                              // child: ToggleButtons(
                              //   onPressed: (index) {
                              //     if (index == 0) {
                              //       setState(() {
                              //         widget.cartItem.quantity =
                              //             widget.cartItem.quantity != 1
                              //                 ? widget.cartItem.quantity - 1
                              //                 : 1;
                              //       });
                              //     } else if (index == 2) {
                              //       setState(() {
                              //         widget.cartItem.quantity++;
                              //       });
                              //     }
                              //   },
                              //   borderRadius: BorderRadius.circular(99),
                              //   children: [
                              //     Icon(
                              //       Icons.remove,
                              //       size: 20,
                              //     ),
                              //     Text('${cartItem.quantity}'),
                              //     Icon(
                              //       Icons.add,
                              //       size: 20,
                              //     ),
                              //   ],
                              //   isSelected: [false, false, false],
                              //   selectedColor:
                              //       const Color.fromARGB(255, 62, 123, 65),
                              //   constraints:
                              //       BoxConstraints(minHeight: 30, minWidth: 30),
                              // ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
