import 'package:farmwise/farmerScreens/models/product.dart';
import 'package:farmwise/farmerScreens/reviewPages/reviewOngoing.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/farmerScreens/reviewPages/reviewPending.dart';
import 'package:farmwise/farmerScreens/data/pendingProposalList.dart';

class ongoingCard extends StatefulWidget {
  const ongoingCard({super.key, required this.proposalList});

  final ProposalDetails proposalList;

  @override
  State<ongoingCard> createState() => _ongoingCardState();
}

class _ongoingCardState extends State<ongoingCard> {
  @override
  Widget build(BuildContext context) {
    final proposalList = widget.proposalList;

    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (Context) => reviewOngoing(proposalList: proposalList),
          ),
        )
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton.filledTonal(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      iconSize: 18,
                      icon: const Icon(
                        Icons.bookmark_add_rounded,
                        color: Color.fromARGB(255, 240, 243, 240),
                      )),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          proposalList.crop_name,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          "Total :Rs.${proposalList.total_amount}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          "My :Rs.${proposalList.investment_of_farmer}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
