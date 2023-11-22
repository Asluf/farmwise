import 'package:farmwise/farmerScreens/data/cultivationProposalList.dart';
import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class reviewApproved extends StatefulWidget {
  const reviewApproved({super.key, required this.proposalList}); 
  //constructor for reviewapproved class
// a required named parameter proposalList of type ProposalDetails. 
//The required keyword indicates that this parameter must be provided when creating an instance of the class.
  final ProposalDetails proposalList;
  // This line declares a final field named proposalList of type ProposalDetails. 
  ///This field will store the data related to the proposal.

  @override
  State<reviewApproved> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<reviewApproved> {
  final AuthService _authService = AuthService();
  String token = '';
  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(); // Fetch data when the profile page loads
  }

  Future<String> fetchData() async {
    token = await _authService.getToken();
    await Future.delayed(const Duration(seconds: 1));
    return "done";
  }

  Future<void> deleteProposal() async {
    var propId = widget.proposalList.proposal_id;
    // print(propId);
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      final Map<String, dynamic> data = {"proposal_id": propId};

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/deleteProposal'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Proposal Deleted!')));

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/farmerDash', (route) => false);
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please try again!')));
      }
    } catch (er) {
      print(er);
    }
  }

  Future<void> _showADeleteConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          buttonPadding: const EdgeInsets.fromLTRB(0, 0, 30, 30),
          content: const Text('Are you sure you want to delete or cancel?'),
          actions: [
            ElevatedButton(
              onPressed: deleteProposal,
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 177, 24, 3)),
                elevation: const MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: const Text("Delete"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 5, 46, 2)),
                elevation: const MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: const Text("Dismiss"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ProposalDetails proposalList = widget.proposalList;
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
        title: Text("Approved Overview"),
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
    final ProposalDetails proposalList = widget.proposalList;
    String roiFarmerString = proposalList.roi_farmer;
    double roiFarmer = double.parse(roiFarmerString);
    double roundedRoiFarmer = double.parse(roiFarmer.toStringAsFixed(2));

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
                  child: Image.network((proposalList != '' &&
                          proposalList.land_img_path != '')
                      ? 'http://localhost:5005/${proposalList.land_img_path}' ??
                          'http://localhost:5005/uploads/culproposal/default.png'
                      : 'http://localhost:5005/uploads/culproposal/default.png'),
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
                        "Crop Name:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        proposalList.crop_name,
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
                        "Crop Details:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: Text(
                        proposalList.crop_details,
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
                        "Start date:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: Text(
                        proposalList.start_date,
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
                        "Total Amount:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        proposalList.total_amount,
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
                        "From Farmer:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        proposalList.investment_of_farmer,
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
                        "Amount Needed (Investor):",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        proposalList.investment_of_investor,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
                        "Expected ROI:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "$roundedRoiFarmer %",
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
                        "Proposal Status:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        proposalList.proposal_status,
                        style: TextStyle(fontSize: 17),
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
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ElevatedButton(
              onPressed: () {
                _showADeleteConfirmationDialog(context);
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 177, 24, 3)),
                elevation: const MaterialStatePropertyAll(4),
                minimumSize: MaterialStatePropertyAll(Size(100, 50)),
                maximumSize: MaterialStatePropertyAll(Size(150, 50)),
                // padding: const MaterialStatePropertyAll(
                //     EdgeInsets.symmetric(horizontal: 70)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Container(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Delete",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Icon(Icons.delete)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
