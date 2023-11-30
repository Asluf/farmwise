import 'package:farmwise/farmerScreens/createProductProposal.dart';
import 'package:farmwise/farmerScreens/data/productProposalList.dart';
import 'package:farmwise/farmerScreens/widgets/products/listedProductsCard.dart';
import 'package:farmwise/farmerScreens/widgets/products/pendingProductsCard.dart';
import 'package:farmwise/farmerScreens/widgets/products/rejectedProductsCard.dart';
import 'package:farmwise/farmerScreens/widgets/products/soldProductsCard.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProposal extends StatefulWidget {
  const ProductProposal({super.key});

  @override
  State<ProductProposal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductProposal> {
  final AuthService _authService = AuthService();
  String email = '';
  String token = '';
  List<ProductProposalDetails> fetchedPendingProducts = [];
  List<ProductProposalDetails> fetchedListedProducts = [];
  List<ProductProposalDetails> fetchedSoldProducts = [];
  List<ProductProposalDetails> fetchedRejectedProducts = [];

  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchPendingData();
  }

  Future<String> fetchPendingData() async {
    email = await _authService.getEmail();
    token = await _authService.getToken();

    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // pendingProducts
      final Map<String, dynamic> data = {
        "email": email,
        "proposal_status": "pending",
        "product_status": "available"
      };
      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getProduct'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['productproposalDetails'];

        for (var proposalJson in proposalsJson) {
          ProductProposalDetails proposal =
              ProductProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedPendingProducts.add(proposal);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
      }
      //Sold products
      final Map<String, dynamic> data2 = {
        "email": email,
        "proposal_status": "Approved",
        "product_status": "sold"
      };
      final response2 = await http.post(
        Uri.parse('http://localhost:5005/api/getProduct'),
        headers: headers,
        body: jsonEncode(data2),
      );
      if (response2.statusCode == 200) {
        Map<String, dynamic> jsonData2 = json.decode(response2.body);
        List<dynamic> proposalsJson2 = jsonData2['productproposalDetails'];

        for (var proposalJson2 in proposalsJson2) {
          ProductProposalDetails proposal2 =
              ProductProposalDetails.fromJson(proposalJson2);
          setState(() {
            fetchedSoldProducts.add(proposal2);
          });
        }
      } else {
        print('Failed to fetch data ${response2.body}');
      }
      //Listed products
      final Map<String, dynamic> data3 = {
        "email": email,
        "proposal_status": "Approved",
        "product_status": "Available"
      };
      final response3 = await http.post(
        Uri.parse('http://localhost:5005/api/getProduct'),
        headers: headers,
        body: jsonEncode(data3),
      );
      if (response3.statusCode == 200) {
        Map<String, dynamic> jsonData3 = json.decode(response3.body);
        List<dynamic> proposalsJson3 = jsonData3['productproposalDetails'];

        for (var proposalJson3 in proposalsJson3) {
          ProductProposalDetails proposal3 =
              ProductProposalDetails.fromJson(proposalJson3);
          setState(() {
            fetchedListedProducts.add(proposal3);
          });
        }
      } else {
        print('Failed to fetch data ${response3.body}');
      }
      //rejected Products
      final Map<String, dynamic> data4 = {
        "email": email,
        "proposal_status": "Rejected",
        "product_status": "Available"
      };
      final response4 = await http.post(
        Uri.parse('http://localhost:5005/api/getProduct'),
        headers: headers,
        body: jsonEncode(data4),
      );
      if (response4.statusCode == 200) {
        Map<String, dynamic> jsonData4 = json.decode(response4.body);
        List<dynamic> proposalsJson4 = jsonData4['productproposalDetails'];

        for (var proposalJson4 in proposalsJson4) {
          ProductProposalDetails proposal4 =
              ProductProposalDetails.fromJson(proposalJson4);
          setState(() {
            fetchedRejectedProducts.add(proposal4);
          });
        }
      } else {
        print('Failed to fetch data ${response4.body}');
      }
    } catch (er) {
      print(er);
    }
    // await Future.delayed(const Duration(seconds: 1));
    return "done";
  }

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
      body: FutureBuilder<String>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, display a loading spinner or an animation
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green.shade600), // Set your desired color
              ),
            );
          } else if (snapshot.hasError) {
            // If there's an error in the Future, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete and data is received, display the data
            // return Text('Data: ${snapshot.data}');
            return Home(context);
          }
        },
      ),
    );
  }

  Widget Home(BuildContext context) {
    // print(fetchedProposals[1].crop_name);
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Listed Products ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedListedProducts.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedListedProducts.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.73,
                ),
                itemCount: fetchedListedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return listedProductCard(
                      productproposalList: fetchedListedProducts[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No listed products",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Pending Products ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedPendingProducts.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedPendingProducts.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.73,
                ),
                itemCount: fetchedPendingProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return pendingProductCard(
                      productproposalList: fetchedPendingProducts[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No pending products",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Sold Products ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedSoldProducts.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedSoldProducts.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.73,
                ),
                itemCount: fetchedSoldProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return soldProductCard(
                      productproposalList: fetchedSoldProducts[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No Sold products",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Rejected Products ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedRejectedProducts.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedRejectedProducts.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.73,
                ),
                itemCount: fetchedRejectedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return rejectedProductCard(
                      productproposalList: fetchedRejectedProducts[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No rejected products",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
      ],
    );
  }
}
