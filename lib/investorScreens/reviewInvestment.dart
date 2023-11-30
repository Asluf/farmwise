import 'package:farmwise/investorScreens/data/progressImageList.dart';
import 'package:farmwise/investorScreens/widgets/progressImageCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/investorScreens/data/cultivationProposalList.dart';
import '../../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewInvestment extends StatefulWidget {
  const ReviewInvestment({super.key, required this.proposalList});
  final ProposalDetails proposalList;

  @override
  State<ReviewInvestment> createState() => _ReviewInvestmentState();
}

class _ReviewInvestmentState extends State<ReviewInvestment> {
  bool _isExpanded = false;
  void toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  final AuthService _authService = AuthService();
  bool _isExpandedd = false;
  late Future<String> futureData;
  String token = '';
  Map<String, dynamic> fetchedProgressImageDetails = {};
  List<String> img = [];
  List<String> dte = [];

  @override
  void initState() {
    super.initState();
    futureData = fetchProgressImageData();
  }

  Future<String> fetchProgressImageData() async {
    token = await _authService.getToken();
    //print(widget.proposalList.proposal_id);
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // pendingData
      final Map<String, dynamic> data = {
        "cultivation_id": widget.proposalList.proposal_id
      };
      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getProgress'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        Map<String, dynamic> imgPaths = jsonData['data']['img_paths'];

        setState(() {
          fetchedProgressImageDetails = imgPaths;
        });
        setListImage();
      } else {
        print('Failed to fetch data ${response.body}');
      }
    } catch (er) {
      print(er);
    }
    return "first change";
  }

  void setListImage() {
    setState(() {
      img = [
        fetchedProgressImageDetails['img1'],
        fetchedProgressImageDetails['img2'],
        fetchedProgressImageDetails['img3'],
        fetchedProgressImageDetails['img4'],
        fetchedProgressImageDetails['img5'],
        fetchedProgressImageDetails['img6'],
        fetchedProgressImageDetails['img7'],
        fetchedProgressImageDetails['img8'],
        fetchedProgressImageDetails['img9'],
        fetchedProgressImageDetails['img10'],
        fetchedProgressImageDetails['img11'],
        fetchedProgressImageDetails['img12']
      ];
      dte = [
        fetchedProgressImageDetails['date1'],
        fetchedProgressImageDetails['date2'],
        fetchedProgressImageDetails['date3'],
        fetchedProgressImageDetails['date4'],
        fetchedProgressImageDetails['date5'],
        fetchedProgressImageDetails['date6'],
        fetchedProgressImageDetails['date7'],
        fetchedProgressImageDetails['date8'],
        fetchedProgressImageDetails['date9'],
        fetchedProgressImageDetails['date10'],
        fetchedProgressImageDetails['date11'],
        fetchedProgressImageDetails['date12']
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
        title: Text("Investment Overview"),
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
    String roiInvestorString = proposalList.roi_investor;
    double roiInvestor = double.parse(roiInvestorString);
    double roundedRoiInvestor = double.parse(roiInvestor.toStringAsFixed(2));
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
              borderRadius: BorderRadius.circular(7),
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
                        "Farmer Name:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        proposalList.farmerDetails.farmer_name,
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
                        "Started date:",
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
                Visibility(
                  visible: !_isExpanded,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: toggleExpansion,
                        child: RoundedIcon(
                          icon: Icons.arrow_downward,
                          backgroundColor: Color.fromARGB(255, 5, 46, 2),
                        ),
                      )
                    ],
                  ),
                ),
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: SizedBox(),
                  secondChild: Container(
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              width: (screenWidth - 60) / 2,
                              child: const Text(
                                "Total Investment:",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Rs. ${proposalList.total_amount}",
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
                                "Rs. ${proposalList.investment_of_farmer}",
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
                                "From Investor:",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Rs. ${proposalList.investment_of_investor}",
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
                                "$roundedRoiInvestor%",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color.fromARGB(255, 5, 46, 2),
                        ),
                        // Sjow less Button
                        Visibility(
                          visible: _isExpanded,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: toggleExpansion,
                                child: RoundedIcon(
                                  icon: Icons.arrow_upward,
                                  backgroundColor:
                                      Color.fromARGB(255, 5, 46, 2),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Progress Images",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return ProgressImageCard(
                    progressImagePath: img[index],
                    progressImageDate: dte[index],
                    cultivation_id: widget.proposalList.proposal_id,
                    index: index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;

  RoundedIcon({required this.icon, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Adjust the width and height as needed
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 20, // Adjust the size of the icon as needed
          color: Colors.white, // Adjust the icon color as needed
        ),
      ),
    );
  }
}
