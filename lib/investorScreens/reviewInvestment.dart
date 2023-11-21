import 'package:farmwise/investorScreens/data/progressImageList.dart';
import 'package:farmwise/investorScreens/widgets/progressImageCard.dart';
import 'package:flutter/material.dart';

class ReviewInvestment extends StatefulWidget {
  const ReviewInvestment({super.key, required this.proposalId});
  final String proposalId;

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
      body: SingleChildScrollView(
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
                    child: Image.asset(
                      'assets/Garlic.jpeg',
                      fit: BoxFit.cover,
                    ),
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
                        child: const Text(
                          "Garlic",
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
                        child: const Text(
                          "Perera",
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
                          "Time Period:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "2023-8-10  to  20223-11-5",
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
                                child: const Text(
                                  "Rs.100,000",
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
                                child: const Text(
                                  "40,000",
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: const Text(
                                  "Rs. 60,000",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
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
                                child: const Text(
                                  "17%",
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
                itemCount: progressImageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProgressImageCard(
                      progressImageList: progressImageList[index]);
                },
              ),
            ),
          ],
        ),
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
