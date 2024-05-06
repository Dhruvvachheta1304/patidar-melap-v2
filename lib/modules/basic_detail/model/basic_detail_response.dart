class BasicDetail {
  BasicDetail(
      {this.sataPeta,
      this.firstname,
      this.lastname,
      this.subcaste,
      this.caste,
      this.mobileNumber,
      this.gender,
      this.educationDetail,
      this.birthdate,
      this.birthtime,
      this.birthplace,
      this.maritalStatus,
      this.weight,
      this.height,
      this.occupation,
      this.income,
      this.userIncomeCurrency,
      this.profilePhoto1Crop,
      this.userAgent});

  BasicDetail.fromJson(dynamic json) {
    sataPeta = json['sata_peta'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    subcaste = json['subcaste'];
    caste = json['caste'];
    mobileNumber = json['mobile_number'];
    gender = json['gender'];
    educationDetail = json['education_detail'];
    birthdate = json['birthdate'];
    birthtime = json['birthtime'];
    birthplace = json['birthplace'];
    maritalStatus = json['marital_status'];
    weight = json['weight'];
    height = json['height'];
    occupation = json['occupation'];
    income = json['income'];
    userIncomeCurrency = json['user_income_currency'];
    profilePhoto1Crop = json['profile_photo1_crop'];
    userAgent = json['user_agent'];
  }

  int? sataPeta;
  String? firstname;
  String? lastname;
  String? subcaste;
  int? caste;
  String? mobileNumber;
  String? gender;
  String? educationDetail;
  String? birthdate;
  String? birthtime;
  String? birthplace;
  String? maritalStatus;
  double? weight;
  String? height;
  String? occupation;
  int? income;
  String? userIncomeCurrency;
  String? profilePhoto1Crop;
  String? userAgent;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sata_peta'] = sataPeta;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['subcaste'] = subcaste;
    data['caste'] = caste;
    data['mobile_number'] = mobileNumber;
    data['gender'] = gender;
    data['education_detail'] = educationDetail;
    data['birthdate'] = birthdate;
    data['birthtime'] = birthtime;
    data['birthplace'] = birthplace;
    data['marital_status'] = maritalStatus;
    data['weight'] = weight;
    data['height'] = height;
    data['occupation'] = occupation;
    data['income'] = income;
    data['user_income_currency'] = userIncomeCurrency;
    data['profile_photo1_crop'] = profilePhoto1Crop;
    data['user_agent'] = userAgent;
    return data;
  }
}
