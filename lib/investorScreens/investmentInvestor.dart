import 'package:farmwise/investorScreens/widgets/investmentCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/investorScreens/data/proposalList.dart';
import 'package:farmwise/investorScreens/widgets/proposalCard.dart';

class InvestmentInvestor extends StatefulWidget {
  const InvestmentInvestor({super.key});

  @override
  State<InvestmentInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InvestmentInvestor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: const Text(
                        "On-going",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 4, 5, 4),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
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
                    return InvestmentCard(proposalList: proposalList[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
