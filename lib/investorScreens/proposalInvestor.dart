import 'package:farmwise/investorScreens/allProposal.dart';
import 'package:farmwise/investorScreens/searchProposal.dart';
import 'package:farmwise/investorScreens/widgets/proposalCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/investorScreens/data/proposalList.dart';

class ProposalInvestor extends StatefulWidget {
  const ProposalInvestor({super.key});

  @override
  State<ProposalInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProposalInvestor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.all(16), children: [
      //filter
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search here..",
                  isDense: true,
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(99),
                      )),
                  //prefixIcon: ,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: IconButton.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchProposal()),
                    );
                  },
                  icon: const Icon(
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
            "Featured Proposals",
            style: TextStyle(
              color: const Color.fromARGB(255, 4, 5, 4),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllProposal()),
              );
            },
            child: Text(
              "See all",
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      // Proposal Items card
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: proposalList.length,
        itemBuilder: (BuildContext context, int index) {
          // returning the cart
          return ProposalCard(proposalList: proposalList[index]);
        },
      ),
    ]));
  }
}
