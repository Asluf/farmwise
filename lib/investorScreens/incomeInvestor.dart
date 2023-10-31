import 'package:flutter/material.dart';

class IncomeInvestor extends StatefulWidget {
  const IncomeInvestor({super.key});

  @override
  State<IncomeInvestor> createState() => _IncomeInvestorState();
}

class _IncomeInvestorState extends State<IncomeInvestor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Its the income page"),
          ],
        ),
      ),
    );
  }
}
