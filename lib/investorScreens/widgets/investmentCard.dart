import 'package:farmwise/investorScreens/reviewInvestment.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/investorScreens/data/cultivationProposalList.dart';

class InvestmentCard extends StatefulWidget {
  const InvestmentCard({super.key, required this.proposalList});
  final ProposalDetails proposalList;

  @override
  State<InvestmentCard> createState() => _InvestmentCardState();
}

class _InvestmentCardState extends State<InvestmentCard> {
  @override
  Widget build(BuildContext context) {
    final proposalList = widget.proposalList;
    double value = double.parse(proposalList.roi_investor);
    String roundedValue = value.toStringAsFixed(2);
    return GestureDetector(
      onTap: () {
        // Navigate to the second page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ReviewInvestment(proposalList: proposalList)),
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
                image: NetworkImage((proposalList != '' &&
                        proposalList.land_img_path != '')
                    ? 'http://localhost:5005/${proposalList.land_img_path}' ??
                        'http://localhost:5005/uploads/culproposal/default.png'
                    : 'http://localhost:5005/uploads/culproposal/default.png'),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Text(
                    proposalList.crop_name,
                    style: TextStyle(fontSize: 13),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                    child: Text(
                      "ROI: ${roundedValue}%",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Text(
                    "Farmer: ${proposalList.farmerDetails.farmer_name}",
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
