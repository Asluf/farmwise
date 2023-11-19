import 'package:farmwise/farmerScreens/createProductProposal.dart';
import 'package:farmwise/farmerScreens/data/productProposalList.dart';
import 'package:farmwise/farmerScreens/widgets/products/listedProductsCard.dart';
import 'package:farmwise/farmerScreens/widgets/products/pendingProductsCard.dart';
import 'package:farmwise/farmerScreens/widgets/products/soldProductsCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/farmerScreens/data/productList.dart';

class ProductProposal extends StatefulWidget {
  const ProductProposal({super.key});

  @override
  State<ProductProposal> createState() => _myInvestmentState();
}

class _myInvestmentState extends State<ProductProposal> {
  List<ProductProposalDetails> fetchedPendingProducts = [];
  List<ProductProposalDetails> fetchedListedProducts = [];
  List<ProductProposalDetails> fetchedSoldProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return createProductProposal();
          }));
        }, // Action to be taken on press
        child: Icon(Icons.add), // Icon to be displayed
        backgroundColor: const Color.fromARGB(
            255, 5, 46, 2), // Optional: specify the background color
        foregroundColor: Colors.white, // Optional: specify the icon color
        tooltip: 'Add Product', // Optional: tooltip text on hover
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
            child: const Text(
              "Listed Products",
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return listedProductCard(
                  productproposalList: fetchedListedProducts[index]);
            },
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
            child: const Text(
              "Pending Products",
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return pendingProductCard(
                  productproposalList: fetchedPendingProducts[index]);
            },
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
            child: const Text(
              "Sold Products",
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return soldProductCard(
                  productproposalList: fetchedSoldProducts[index]);
            },
          )
        ],
      ),
    );
  }
}
