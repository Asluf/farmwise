import 'package:farmwise/investorScreens/data/approvedProposalList.dart';
import 'package:farmwise/investorScreens/models/proposal.dart';
import 'package:farmwise/investorScreens/proposalInvestor.dart';
import 'package:farmwise/investorScreens/reviewProposal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/services/auth_services.dart';

class RequestedCard extends StatelessWidget {
  const RequestedCard({super.key, required this.proposalList});

  final ApprovedProposalDetails proposalList;

  @override
  Widget build(BuildContext context) {
    final ProposalInvestor objProposalInvestor = ProposalInvestor();
    final AuthService _authService = AuthService();
    String token = '';
    String email = '';

    Future<void> deleteRequested(String proposal_id) async {
      token = await _authService.getToken();
      email = await _authService.getEmail();
      try {
        final Map<String, String> headers = {
          'authorization': 'Bearer $token',
          'x-access-token': token,
          'Content-Type': 'application/json'
        };
        final Map<String, dynamic> data = {
          "investor_email": email,
          "proposal_id": proposal_id
        };

        final response = await http.post(
          Uri.parse('http://localhost:5005/api/deleteRequestedCultivation'),
          headers: headers,
          body: jsonEncode(data),
        );
        //saving the response
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Request Deleted successfully!')));
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/investorDash', (route) => false);
          });
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Oops! Try again..')));
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/investorDash', (route) => false);
          });
        }
      } catch (er) {
        print(er);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(er.toString())));
      }
    }

    return GestureDetector(
      onTap: () {},
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
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    "ROI: ${proposalList.roi_investor}%",
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    "Farmer: ${proposalList.farmerDetails.farmer_name}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Text(
                    "Requested",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(214, 110, 99, 87)),
                  ),
                  TextButton(
                      onPressed: () {
                        deleteRequested(proposalList.proposal_id);
                      },
                      child: const Icon(
                        Icons.delete_forever_rounded,
                        color: Color.fromARGB(255, 157, 67, 60),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
