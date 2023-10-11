import 'package:farmwise/investorScreens/models/proposal.dart';
import 'package:farmwise/investorScreens/reviewInvestment.dart';
import 'package:flutter/material.dart';

class InvestmentCard extends StatelessWidget {
  const InvestmentCard({super.key, required this.proposalList});

  final Proposal proposalList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the second page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ReviewInvestment(proposalId: proposalList.proposalId)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias, //clip the edges
        elevation: 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: 0.2,
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // image
            Container(
              height: 120,
              alignment: Alignment.topRight,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  proposalList.image,
                ),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Text(
                    proposalList.cropName,
                    style: TextStyle(fontSize: 13),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                    child: Text(
                      "ROI: ${proposalList.expectedRoiInvestor}%",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Text(
                    "Farmer: ${proposalList.farmerName}",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
