import 'package:flutter/material.dart';

class PaymentInvestor extends StatefulWidget {
  const PaymentInvestor({super.key, required this.proposal_id});
  final String proposal_id;

  @override
  State<PaymentInvestor> createState() => _PaymentInvestorState();
}

class _PaymentInvestorState extends State<PaymentInvestor> {
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
          title: const Text("Payment Gateway"),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Text("proposal ID is ${widget.proposal_id}"),
            ],
          ),
        )));
  }
}
