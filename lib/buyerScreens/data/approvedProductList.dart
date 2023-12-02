class FarmerData {
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

  FarmerData({
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

  factory FarmerData.fromJson(Map<String, dynamic> json) {
    return FarmerData(
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

class ApprovedProductProposalDetails {
  String product_id;
  String farmer_email;
  String product_name;
  String product_details;
  String quantity;
  String unit_price;
  String total_price;
  String produced_date;
  String expire_date;
  String buyer_email;
  String product_img_path;
  String product_status;
  String proposal_status;
  String created_date;
  String response;
  FarmerData farmerDetails;

  ApprovedProductProposalDetails({
    required this.product_id,
    required this.farmer_email,
    required this.product_name,
    required this.product_details,
    required this.quantity,
    required this.unit_price,
    required this.total_price,
    required this.produced_date,
    required this.expire_date,
    required this.buyer_email,
    required this.product_img_path,
    required this.product_status,
    required this.proposal_status,
    required this.created_date,
    required this.response,
    required this.farmerDetails,
  });

  factory ApprovedProductProposalDetails.fromJson(Map<String, dynamic> json) {
    return ApprovedProductProposalDetails(
      product_id: json['_id'] ?? '',
      farmer_email: json['farmer_email'] ?? '',
      product_name: json['product_name'] ?? '',
      product_details: json['product_details'] ?? '',
      quantity: json['quantity'] ?? '',
      unit_price: json['unit_price'] ?? '',
      total_price: json['total_price'] ?? '',
      produced_date: json['produced_date'] ?? '',
      expire_date: json['expire_date'] ?? '',
      buyer_email: json['buyer_email'] ?? '',
      product_img_path: json['product_img_path'] ?? '',
      product_status: json['product_status'] ?? '',
      proposal_status: json['proposal_status'] ?? '',
      created_date: json['created_date'] ?? '',
      response: json['response'] ?? '',
      farmerDetails: FarmerData.fromJson(json['farmerDetails'] ?? {}),
    );
  }
}
