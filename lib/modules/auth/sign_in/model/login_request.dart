class LogInRequest {
  LogInRequest({
    this.mobileNumber,
    this.password,
    this.userAgent,
    this.status,
    this.message,
  });

  LogInRequest.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    // code = json['code'];
  }

  String? mobileNumber;
  String? password;
  String? userAgent;
  String? message;
  String? status;

  Map<String, dynamic> toJSON() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['password'] = password;
    map['user_agent'] = 'NI-AAPP';

    return map;
  }
}
