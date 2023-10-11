import 'package:flutter/material.dart';
import 'package:farmwise/investorScreens/data/proposalList.dart';
import 'package:farmwise/investorScreens/widgets/proposalCard.dart';

class SearchProposal extends StatefulWidget {
  const SearchProposal({super.key});

  @override
  State<SearchProposal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchProposal> {
  @override
  Widget build(BuildContext context) {
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
          title: Text("Filtered Proposals"),
        ),
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
                        ),
                      ),
                      //prefixIcon: ,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 107, 156, 104),
                      )),
                )
              ],
            ),
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
                return ProposalCard(proposalList: proposalList[index]);
              })
        ]));
  }
}
