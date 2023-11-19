import 'package:farmwise/farmerScreens/data/pendingProposalList.dart';
import 'package:farmwise/farmerScreens/data/productList.dart';
import 'package:farmwise/investorScreens/data/proposalList.dart';
import 'package:flutter/material.dart';

class reviewApproved extends StatefulWidget {
  const reviewApproved({super.key, required this.proposalList});

  final ProposalDetails proposalList;

  @override
  State<reviewApproved> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<reviewApproved> {
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
        ],
      ),
    );
  }
}
