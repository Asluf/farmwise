import 'package:farmwise/buyerScreens/data/ApprovedProductList.dart';
import 'package:farmwise/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class reviewApprovedProducts extends StatefulWidget {
  reviewApprovedProducts({super.key, required this.productproposalList});

  final ApprovedProductProposalDetails productproposalList;

  @override
  State<reviewApprovedProducts> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<reviewApprovedProducts> {
  final AuthService _authService = AuthService();
  String token = '';
  String email = '';
  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(); // Fetch data when the profile page loads
  }

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return "done";
  }

  Future<void> requestProduct(String proposal_id) async {
    setState(() {
      futureData = Future.value("Requesting");
    });
    email = await _authService.getEmail();
    token = await _authService.getToken();
    // calling to api to change the status
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json'
      };
      final Map<String, dynamic> data = {
        "product_id": proposal_id,
        "buyer_email": email
      };

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/requestProducts'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print('Requested successfully');

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Requested successfully')));

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/buyerDash', (route) => false);
        });
      } else {
        print('Failed to send POST request');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to request. Try again')));

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/buyerDash', (route) => false);
        });
      }
    } catch (er) {
      print(er);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ApprovedProductProposalDetails productproposalList =
        widget.productproposalList;
    // print(proposalList.crop_details);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("bgAppbar.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text("Product Overview"),
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
            return review(context);
          }
        },
      ),
    );
  }

  Widget review(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ApprovedProductProposalDetails productproposalList =
        widget.productproposalList;
    //String roiFarmerString = proposalList.roi_farmer;
    //double roiFarmer = double.parse(roiFarmerString);
    //double roundedRoiFarmer = double.parse(roiFarmer.toStringAsFixed(2));
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      width: 10,
                      color: Color.fromARGB(255, 192, 226, 190),
                    ),
                  ),
                ),
                width: (screenWidth / 2) - 10,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network((productproposalList != '' &&
                          productproposalList.product_img_path != '')
                      ? 'http://localhost:5005/${productproposalList.product_img_path}' ??
                          'http://localhost:5005/uploads/proproposal/defaultproduct.png'
                      : 'http://localhost:5005/uploads/proproposal/defaultproduct.png'),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 192, 226, 190),
              borderRadius: BorderRadius.circular(5),
            ),
            width: screenWidth - 30,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Product Name:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        productproposalList.product_name,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Product Details:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: Text(
                        productproposalList.product_details,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Produced date:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: Text(
                        productproposalList.produced_date,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Expired date:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: Text(
                        productproposalList.expire_date,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Quantity:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        productproposalList.quantity,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Unit Price:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        productproposalList.unit_price,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Total price:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        productproposalList.total_price,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ElevatedButton(
              onPressed: () {
                _showAcceptConfirmationDialog(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 5, 46, 2)),
                elevation: MaterialStatePropertyAll(4),
                minimumSize:
                    MaterialStatePropertyAll(Size(screenWidth - 100, 50)),
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 70)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: const Text(
                "Request",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAcceptConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          // icon: const Icon(Icons.check),
          buttonPadding: EdgeInsets.fromLTRB(0, 0, 30, 30),
          // title: Text('Confirm Logout'),
          content:
              Text('Are you sure you want to accept or cancel the proposal?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                requestProduct(widget.productproposalList.product_id);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 5, 46, 2)),
                elevation: MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text("Request"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 177, 24, 3)),
                elevation: MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text("Dismiss"),
            ),
          ],
        );
      },
    );
  }
}
