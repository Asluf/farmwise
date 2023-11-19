import 'package:farmwise/farmerScreens/models/product.dart';
import 'package:farmwise/farmerScreens/reviewPages/products/reviewPendingProducts.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/farmerScreens/data/productProposalList.dart';

class pendingProductCard extends StatefulWidget {
  const pendingProductCard({super.key, required this.productproposalList});

  final ProductProposalDetails productproposalList;

  @override
  State<pendingProductCard> createState() => _pendingProductCardState();
}

class _pendingProductCardState extends State<pendingProductCard> {
  @override
  Widget build(BuildContext context) {
    final productproposalList = widget.productproposalList;

    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                // ignore: non_constant_identifier_names
                (Context) => const reviewPendingProducts(),
          ),
        )
      },
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
                  image: NetworkImage((productproposalList != '' &&
                          productproposalList.product_img_path != '')
                      ? 'http://localhost:5005/${productproposalList.product_img_path}' ??
                          'http://localhost:5005/uploads/proproposal/defaultproduct.png'
                      : 'http://localhost:5005/uploads/proproposal/defaultproduct.png'),
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
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      productproposalList.product_name,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Unit Price :Rs.${productproposalList.unit_price}",
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                        TextSpan(
                          text:
                              "Total Price: Rs.${productproposalList.unit_price}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ])),
                      SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const Icon(null)))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
