class ProgressImages {
  String img1;
  String date1;
  String img2;
  String date2;
  String img3;
  String date3;
  String img4;
  String date4;
  String img5;
  String date5;
  String img6;
  String date6;
  String img7;
  String date7;
  String img8;
  String date8;
  String img9;
  String date9;
  String img10;
  String date10;
  String img11;
  String date11;
  String img12;
  String date12;

  ProgressImages({
    required this.img1,
    required this.date1,
    required this.img2,
    required this.date2,
    required this.img3,
    required this.date3,
    required this.img4,
    required this.date4,
    required this.img5,
    required this.date5,
    required this.img6,
    required this.date6,
    required this.img7,
    required this.date7,required this.img8,
    required this.date8,required this.img9,
    required this.date9,required this.img10,
    required this.date10,required this.img11,
    required this.date11,required this.img12,
    required this.date12,
  });

  factory ProgressImages.fromJson(Map<String, dynamic> json) {
    return ProgressImages(
      img1: json['img1'] ?? '',
      date1: json['date1'] ?? '',
      img2: json['img2'] ?? '',
      date2: json['date2'] ?? '',
      img3: json['img3'] ?? '',
      date3: json['date3'] ?? '',
      img4: json['img4'] ?? '',
      date4: json['date4'] ?? '',
      img5: json['img5'] ?? '',
      date5: json['date5'] ?? '',
      img6: json['img6'] ?? '',
      date6: json['date6'] ?? '',
      img7: json['img7'] ?? '',
      date7: json['date7'] ?? '',
      img8: json['img8'] ?? '',
      date8: json['date8'] ?? '',
      img9: json['img9'] ?? '',
      date9: json['date9'] ?? '',
      img10: json['img10'] ?? '',
      date10: json['date10'] ?? '',
      img11: json['img11'] ?? '',
      date11: json['date11'] ?? '',
      img12: json['img12'] ?? '',
      date12: json['date12'] ?? '',
    );
  }

}

class ProgressImageDetails {
  String cultivation_id;
  String farmer_email;
  String investor_email;
  String created_date;
  ProgressImages img_paths;

  ProgressImageDetails({
    required this.cultivation_id,
    required this.farmer_email,
    required this.investor_email,
    required this.created_date,
    required this.img_paths,
  });

  factory ProgressImageDetails.fromJson(Map<String, dynamic> json) {
    return ProgressImageDetails(
      cultivation_id: json['cultivation_id'] ?? '',
      farmer_email: json['farmer_email'] ?? '',
      investor_email: json['investor_email'] ?? '',
      created_date: json['created_date'] ?? '',
      img_paths: ProgressImages.fromJson(json['img_paths'] ?? {}),
    );
  }
}


// {"_id":{"$oid":"653a66d2240b32d8e91167b3"},"cultivation_id":"6558f7534e853f1ecae3a6b1","farmer_email":"farmer@gmail.com","investor_email":"investor@gmail.com","img_paths":{"img1":"","img2":"","img3":"","img4":"","img5":"","img6":"","img7":"","img8":"","img9":"","img10":"","img11":"","img12":"","date1":{"$date":{"$numberLong":"1698796800000"}},"date10":{"$date":{"$numberLong":"1703721600000"}},"date11":{"$date":{"$numberLong":"1704067200000"}},"date12":{"$date":{"$numberLong":"1704585600000"}},"date2":{"$date":{"$numberLong":"1699315200000"}},"date3":{"$date":{"$numberLong":"1699920000000"}},"date4":{"$date":{"$numberLong":"1700524800000"}},"date5":{"$date":{"$numberLong":"1701129600000"}},"date6":{"$date":{"$numberLong":"1701388800000"}},"date7":{"$date":{"$numberLong":"1701907200000"}},"date8":{"$date":{"$numberLong":"1702512000000"}},"date9":{"$date":{"$numberLong":"1703116800000"}}},"created_date":{"$date":{"$numberLong":"1698345000000"}}}

// {"_id":{"$oid":"653a66d2240b32d8e91167b3"},"cultivation_id":"6558f7534e853f1ecae3a6b1","farmer_email":"farmer@gmail.com","investor_email":"investor@gmail.com","img_paths":{{"img1":"","date1":{"$date":{"$numberLong":"1698796800000"}}},{"img2":"","date2":{"$date":{"$numberLong":"1698796800000"}}},{"img3":"","date3":{"$date":{"$numberLong":"1698796800000"}}},{"img4":"","date4":{"$date":{"$numberLong":"1698796800000"}}},{"img5":"","date5":{"$date":{"$numberLong":"1698796800000"}}},{"img6":"","date6":{"$date":{"$numberLong":"1698796800000"}}},{"img7":"","date7":{"$date":{"$numberLong":"1698796800000"}}},{"img8":"","date8":{"$date":{"$numberLong":"1698796800000"}}},{"img9":"","date9":{"$date":{"$numberLong":"1698796800000"}}},{"img10":"","date10":{"$date":{"$numberLong":"1698796800000"}}},{"img11":"","date11":{"$date":{"$numberLong":"1698796800000"}}},{"img12":"","date12":{"$date":{"$numberLong":"1698796800000"}}}},"created_date":{"$date":{"$numberLong":"1698345000000"}}}