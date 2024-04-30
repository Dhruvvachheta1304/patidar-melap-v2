class LogInRequest {
  LogInRequest({
    this.mobileNumber,
    this.password,
    this.userAgent,
  });

  String? mobileNumber;
  String? password;
  String? userAgent;

  Map<String, dynamic> toJSON() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['password'] = password;
    map['user_agent'] = 'NI-AAPP';

    return map;
  }
}
