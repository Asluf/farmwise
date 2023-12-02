import 'package:farmwise/buyerScreens/data/ApprovedProductList.dart';
import 'package:farmwise/buyerScreens/data/cartData.dart';
import 'package:farmwise/buyerScreens/data/productList.dart';
import 'package:farmwise/buyerScreens/models/product.dart';
import 'package:farmwise/buyerScreens/widgets/productCard.dart';
import 'package:farmwise/buyerScreens/widgets/requestedProductCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/services/auth_services.dart';

class explorePage extends StatefulWidget {
  const explorePage({super.key});

  @override
  State<explorePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<explorePage> {
  final AuthService _authService = AuthService();
  String token = '';
  String email = '';
  List<ApprovedProductProposalDetails> fetchedApprovedProducts = [];
  List<ApprovedProductProposalDetails> fetchedRequestedProducts = [];

  List<product> cartList = [];
  List<product> filteredList = [];
  TextEditingController searchController = TextEditingController();

  final sortOptions = ['Product Name (A-Z)', 'Product Name (Z-A)'];
  String? selectedSortOption; // Remove the initial value

  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    // Set filteredList to all products when the page loads
    filteredList = List.from(productList);
    selectedSortOption = null; // No default sorting
    futureData = fetchApprovedProducts();
  }

  Future<String> fetchApprovedProducts() async {
    token = await _authService.getToken();
    email = await _authService.getEmail();

    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // pendingData
      final response = await http.post(
        Uri.parse('http://localhost:5005/api/showProducts'),
        headers: headers,
        body: "",
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['approvedProductDetails'];

        for (var proposalJson in proposalsJson) {
          ApprovedProductProposalDetails proposal =
              ApprovedProductProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedApprovedProducts.add(proposal);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
      }
      //RequestedProducts
      final Map<String, dynamic> data = {"buyer_email": email};
      final response2 = await http.post(
        Uri.parse('http://localhost:5005/api/showRequestedProducts'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response2.statusCode == 200) {
        Map<String, dynamic> jsonData2 = json.decode(response2.body);
        List<dynamic> proposalsJson2 = jsonData2['requestedProductDetails'];

        for (var proposalJson2 in proposalsJson2) {
          ApprovedProductProposalDetails proposal2 =
              ApprovedProductProposalDetails.fromJson(proposalJson2);
          setState(() {
            fetchedRequestedProducts.add(proposal2);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
      }
    } catch (er) {
      print(er);
    }
    await Future.delayed(const Duration(seconds: 1));
    return "done";
  }

  void sortProductsByName() {
    setState(() {
      filteredList.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void sortProductsByNameDescending() {
    setState(() {
      filteredList.sort((a, b) => b.name.compareTo(a.name));
    });
  }

  void onDropDownChanged(String? value) {
    if (value != null) {
      setState(() {
        selectedSortOption = value;
        if (value == 'Product Name (A-Z)') {
          sortProductsByName();
        } else if (value == 'Product Name (Z-A)') {
          sortProductsByNameDescending();
        }
        // Add other sorting options if needed
      });
    }
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = List.from(productList);
      } else {
        filteredList = productList
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
// Group filteredList by the first letter of the product name
    Map<String, List<product>> groupedProducts = {};
    for (var product in filteredList) {
      String firstLetter = product.name[0].toUpperCase();
      if (!groupedProducts.containsKey(firstLetter)) {
        groupedProducts[firstLetter] = [];
      }
      groupedProducts[firstLetter]!.add(product);
    }

    return Scaffold(
      body: FutureBuilder<String>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green.shade600), // Set your desired color
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return FeaturedProducts(context);
          }
        },
      ),
    );
  }

  Widget FeaturedProducts(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        //filter
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    // Update the filteredList when the search query changes
                    filterProducts(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search here..",
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(99),
                        )),
                    //prefixIcon: ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: IconButton.filled(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 107, 156, 104),
                    )),
              )
            ],
          ),
        ),
        //consultation
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: SizedBox(
            height: 170,
            child: Card(
              color: Colors.green.shade50,
              elevation: 0.1,
              shadowColor: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Free Consultation",
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Get free support from our customer service"),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 85, 127, 83)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Call now",
                                style: TextStyle(),
                              ))
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/contact_us.png",
                      width: 140,
                    ),
                  ],
                ),
              ),

              //image
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Products",
              style: TextStyle(
                color: const Color.fromARGB(255, 4, 5, 4),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              //crop
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white70,
              ),
              child: DropdownButton<String?>(
                items: sortOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                value: selectedSortOption,
                onChanged: onDropDownChanged,
                underline: Container(),
                hint: Text(
                  selectedSortOption ?? "Sort by",
                  style: TextStyle(
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            )
          ],
        ),
        fetchedApprovedProducts.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: fetchedApprovedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ApprovedProductCard(
                      productproposalList: fetchedApprovedProducts[index]);
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
                    "No featured products",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Requested Products",
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 5, 4),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        fetchedRequestedProducts.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.68,
                ),
                itemCount: fetchedRequestedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  // returning the cart
                  return requestedProductCard(
                      productproposalList: fetchedRequestedProducts[index]);
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
                    "No requested proposals",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
      ],
    );
  }
}
