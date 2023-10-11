class Proposal {
  final String proposalId;
  final String cropName;
  final String farmerName;
  final String description;
  final String image;
  final String timePeriod;
  final double expectedRoiInvestor;
  final double totalInvestment;
  final double fromFarmer;
  final double fromInvestor;

  const Proposal({
    required this.proposalId,
    required this.cropName,
    required this.farmerName,
    required this.description,
    required this.image,
    required this.timePeriod,
    required this.expectedRoiInvestor,
    required this.totalInvestment,
    required this.fromFarmer,
    required this.fromInvestor,
  });
}
