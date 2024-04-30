class SignUpRequest {
  SignUpRequest({
    this.user,
    this.token,
    this.message,
    this.status,
    this.countryCode,
    this.email,
    this.mobileNumber,
    this.otp,
    this.password,
    this.userAgent,
    this.username,
  });

  SignUpRequest.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    message = json['message'];
    status = json['status'];
  }

  User? user;
  String? token;
  String? message;
  String? status;
  String? username;
  String? email;
  String? mobileNumber;
  String? password;
  String? countryCode;
  String? userAgent;
  String? otp;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['username'] = username;
    data['mobile_number'] = mobileNumber;
    data['password'] = password;
    data['email'] = email;
    data['user_agent'] = userAgent;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    return data;
  }
}

class User {
  User(
      {this.id,
      this.status,
      this.email,
      this.username,
      this.mobile,
      this.loggedIn,
      this.basicDetailCompleted,
      this.familyDetailCompleted,
      this.otherDetailCompleted});

  User.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    email = json['email'];
    username = json['username'];
    mobile = json['mobile'];
    loggedIn = json['logged_in'];
    basicDetailCompleted = json['basic_detail_completed'];
    familyDetailCompleted = json['family_detail_completed'];
    otherDetailCompleted = json['other_detail_completed'];
  }

  String? id;
  String? status;
  Null? basicDetailCompleted;
  Null? familyDetailCompleted;
  Null? otherDetailCompleted;
  String? loggedIn;
  String? username;
  String? email;
  String? mobile;
  String? password;
  String? countryCode;
  String? userAgent;
  String? otp;

  // "password": passwordController.text,
  // "otp": pinController.text

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['email'] = email;
    data['username'] = username;
    data['mobile'] = mobile;
    data['logged_in'] = loggedIn;
    data['basic_detail_completed'] = basicDetailCompleted;
    data['family_detail_completed'] = familyDetailCompleted;
    data['other_detail_completed'] = otherDetailCompleted;
    return data;
  }
}
