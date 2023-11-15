import 'package:farmwise/buyerScreens/data/cartData.dart';
import 'package:farmwise/buyerScreens/models/product.dart';
import 'package:flutter/material.dart';

class productCard extends StatelessWidget {
  const productCard(
      {super.key, required this.productList, required this.onAddToCart});

  final product productList;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, //clip the edges
      elevation: 0.1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          width: 0.2,
          color: Colors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 120,
              alignment: Alignment.topRight,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  productList.image,
                ),
                fit: BoxFit.cover,
              )),
              child: SizedBox(
                width: 30,
                height: 30,
                child: IconButton.filledTonal(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    iconSize: 18,
                    icon: const Icon(
                      Icons.bookmark_add_rounded,
                      color: Color.fromARGB(255, 240, 243, 240),
                    )),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    productList.name,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Rs.${productList.price}",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      TextSpan(
                          text: " ${productList.unit}",
                          style: TextStyle(
                            fontSize: 10,
                          ))
                    ])),
                    SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              CartData.cartList.add(productList);
                            },
                            icon: const Icon(Icons.add)))
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
