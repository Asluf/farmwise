class PendingProposalData {
  bool success;
  String message;
  UserData data; 
  List<ProposalDetails> proposalDetails;

  PendingProposalData({
    required this.success,
    required this.message,
    required this.data,
    required this.proposalDetails,
  });

  factory PendingProposalData.fromJson(Map<String, dynamic> json) {
    return PendingProposalData(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
      proposalDetails: (json['proposalDetails'] as List<dynamic>)
          .map((detailsJson) => ProposalDetails.fromJson(detailsJson))
          .toList(),
    );
  }
}

class UserData {
  String farmer_name;
  String farmer_address;
  String farm_address;
  String mobile_number;
  String farmer_reg_id;
  String gs_division;
  String gs_name;
  String gs_mobile;
  String province;
  String district;
  String city;

  UserData({
    required this.farmer_name,
    required this.farmer_address,
    required this.farm_address,
    required this.mobile_number,
    required this.farmer_reg_id,
    required this.gs_division,
    required this.gs_name,
    required this.gs_mobile,
    required this.province,
    required this.district,
    required this.city,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      farmer_name: json['farmer_name'] ?? '',
      farmer_address: json['farmer_address'] ?? '',
      farm_address: json['farm_address'] ?? '',
      mobile_number: json['mobile_number'] ?? '',
      farmer_reg_id: json['farmer_reg_id'] ?? '',
      gs_division: json['gs_division'] ?? '',
      gs_name: json['gs_name'] ?? '',
      gs_mobile: json['gs_mobile'] ?? '',
      province: json['province'] ?? '',
      district: json['district'] ?? '',
      city: json['city'] ?? '',
    );
  }
}

class ProposalDetails {
  String proposal_id;
  String farmer_email;
  String crop_name;
  String crop_details;
  String duration;
  String start_date;
  String acres;
  String total_amount;
  String investment_of_farmer;
  String investment_of_investor;
  String roi_farmer;
  String roi_investor;
  String years_of_experience;
  String land_img_path;
  String proposal_status;
  String investor_email;
  String cultivation_status;
  String created_date;
  String payment_status;
  String prposal_response;
  UserData farmerDetails;

  ProposalDetails({
    required this.proposal_id,
    required this.farmer_email,
    required this.crop_name,
    required this.crop_details,
    required this.duration,
    required this.start_date,
    required this.acres,
    required this.total_amount,
    required this.investment_of_farmer,
    required this.investment_of_investor,
    required this.roi_farmer,
    required this.roi_investor,
    required this.years_of_experience,
    required this.land_img_path,
    required this.proposal_status,
    required this.investor_email,
    required this.cultivation_status,
    required this.created_date,
    required this.payment_status,
    required this.prposal_response,
    required this.farmerDetails,
  });

  factory ProposalDetails.fromJson(Map<String, dynamic> json) {
    return ProposalDetails(
      proposal_id: json['_id'] ?? '',
      farmer_email: json['farmer_email'] ?? '',
      crop_name: json['crop_name'] ?? '',
      crop_details: json['crop_details'] ?? '',
      duration: json['duration'] ?? '',
      start_date: json['start_date'] ?? '',
      acres: json['acres'] ?? '',
      total_amount: json['total_amount'] ?? '',
      investment_of_farmer: json['investment_of_farmer'] ?? '',
      investment_of_investor: json['investment_of_investor'] ?? '',
      roi_farmer: json['roi_farmer'] ?? '',
      roi_investor: json['roi_investor'] ?? '',
      years_of_experience: json['years_of_experience'] ?? '',
      land_img_path: json['land_img_path'] ?? '',
      proposal_status: json['proposal_status'] ?? '',
      investor_email: json['investor_email'] ?? '',
      cultivation_status: json['cultivation_status'] ?? '',
      created_date: json['created_date'] ?? '',
      payment_status: json['payment_status'] ?? '',
      prposal_response: json['proposal_response'] ?? '',
      farmerDetails: UserData.fromJson(json['farmerDetails'] ?? {}),
    );
  }
}

