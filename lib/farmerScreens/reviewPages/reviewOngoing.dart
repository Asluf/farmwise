import 'package:farmwise/farmerScreens/data/cultivationProposalList.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/farmerScreens/widgets/progressImageCard.dart';
import '../../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class reviewOngoing extends StatefulWidget {
  const reviewOngoing({super.key, required this.proposalList});

  final ProposalDetails proposalList;

  @override
  State<reviewOngoing> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<reviewOngoing> {
  final AuthService _authService = AuthService();
  bool _isExpandedd = false;
  late Future<String> futureData;
  late Future<String> futureData2;
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
        title: const Text("Ongoing Overview"),
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
                      padding: const EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Crop Name:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        proposalList.crop_name,
                        style: const TextStyle(fontSize: 17),
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
                      padding: const EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Crop Details:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: Text(
                        proposalList.crop_details,
                        style: const TextStyle(fontSize: 17),
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
                      padding: const EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: const Text(
                        "Start date:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: (screenWidth - 60) / 2,
                      child: Text(
                        proposalList.start_date,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 5, 46, 2),
                ),
                ExpansionTile(
                  title: _isExpandedd
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Show Less',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Show More',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                  collapsedTextColor: const Color.fromARGB(255, 5, 46, 2),
                  textColor: const Color.fromARGB(255, 5, 46, 2),
                  iconColor: const Color.fromARGB(255, 5, 46, 2),
                  backgroundColor: const Color.fromARGB(255, 192, 226, 190),
                  initiallyExpanded: _isExpandedd,
                  onExpansionChanged: (value) {
                    setState(() {
                      _isExpandedd = value;
                    });
                  },
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "Investor Email:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: Text(
                            proposalList.investor_email,
                            style: const TextStyle(fontSize: 17),
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
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "Total Amount:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            proposalList.total_amount,
                            style: const TextStyle(fontSize: 17),
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
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "From Farmer:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            proposalList.investment_of_farmer,
                            style: const TextStyle(fontSize: 17),
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
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "From Investor:",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            proposalList.investment_of_investor,
                            style: const TextStyle(
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
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "Expected ROI:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "$roundedRoiFarmer %",
                            style: const TextStyle(fontSize: 17),
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
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "Proposal Status:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            proposalList.proposal_status,
                            style: const TextStyle(fontSize: 17),
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
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "Cultivation Status:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            proposalList.cultivation_status,
                            style: const TextStyle(fontSize: 17),
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
                          padding: const EdgeInsets.all(10),
                          width: (screenWidth - 60) / 2,
                          child: const Text(
                            "Payment status:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            proposalList.paid,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 5, 46, 2),
                    ),
                  ],
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
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
