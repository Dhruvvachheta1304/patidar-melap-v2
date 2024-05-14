class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.token,
    this.userData,
    this.planId,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    if (json['user_data'] != null) {
      if (json['user_data'] is List<dynamic>) {
        userData = null;
      } else {
        userData = UserData.fromJson(json['user_data'] as Map<String, dynamic>);
      }
    }
    // userData = json['user_data'] != null ?
    // UserData.fromJson(json['user_data'] as Map<String, dynamic>) : null;
    planId = json['plan_id'];
  }

  String? status;
  String? message;
  String? token;
  UserData? userData;
  String? planId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    data['plan_id'] = planId;
    return data;
  }
}

class UserData {
  UserData({
    this.id,
    this.matriId,
    this.indexNumber,
    this.status,
    this.email,
    this.username,
    this.planName,
    this.planStatus,
    this.mobile,
    this.mobileVerifyStatus,
    this.loggedIn,
    this.basicDetailCompleted,
    this.familyDetailCompleted,
    this.otherDetailCompleted,
    this.photosCompleted,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matriId = json['matri_id'];
    indexNumber = json['index_number'];
    status = json['status'];
    email = json['email'];
    username = json['username'];
    planName = json['plan_name'];
    planStatus = json['plan_status'];
    mobile = json['mobile'];
    mobileVerifyStatus = json['mobile_verify_status'];
    loggedIn = json['logged_in'];
    basicDetailCompleted = json['basic_detail_completed'];
    familyDetailCompleted = json['family_detail_completed'];
    otherDetailCompleted = json['other_detail_completed'];
    photosCompleted = json['photos_completed'];
  }

  String? id;
  String? matriId;
  String? indexNumber;
  String? status;
  String? email;
  String? username;
  String? planName;
  String? planStatus;
  String? mobile;
  String? mobileVerifyStatus;
  String? loggedIn;
  bool? basicDetailCompleted;
  bool? familyDetailCompleted;
  bool? otherDetailCompleted;
  bool? photosCompleted;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['matri_id'] = matriId;
    data['index_number'] = indexNumber;
    data['status'] = status;
    data['email'] = email;
    data['username'] = username;
    data['plan_name'] = planName;
    data['plan_status'] = planStatus;
    data['mobile'] = mobile;
    data['mobile_verify_status'] = mobileVerifyStatus;
    data['logged_in'] = loggedIn;
    data['basic_detail_completed'] = basicDetailCompleted;
    data['family_detail_completed'] = familyDetailCompleted;
    data['other_detail_completed'] = otherDetailCompleted;
    data['photos_completed'] = photosCompleted;
    return data;
  }
}
