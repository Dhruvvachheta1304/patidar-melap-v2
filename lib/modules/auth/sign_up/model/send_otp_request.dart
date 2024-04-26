class SendOtpRequest {
  SendOtpRequest({this.mobileNumber, this.type, this.countryCode});

  SendOtpRequest.fromJson(dynamic json) {
    // status = json['status'];
    // code = json['code'];
    mobileNumber = json['mobile_number'];
    type = json['type'];
    countryCode = json['country_code'];
  }

  // String? status;
  // String? code;
  String? mobileNumber;
  String? type;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['status'] = status;
    // data['code'] = code;
    data['country_code'] = countryCode;
    data['mobile_number'] = mobileNumber;
    data['type'] = 'register';
    return data;
  }
}
