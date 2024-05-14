class UserDataModel {
  UserDataModel(
      {this.basicDetailCompleted,
      this.familyDetailCompleted,
      this.otherDetailCompleted,
      this.basicDetail,
      this.familyDetail,
      this.otherDetail,
      this.photosCompleted,
      this.indexNumber,
      this.photos,
      this.status,
      this.message,
      this.sortlisted,
      this.blocked,
      this.viewedMyBiodataCount,
      this.shortListMyBioDataCount,
      this.age});

  UserDataModel.fromJson(dynamic json) {
    basicDetailCompleted = json['basic_detail_completed'];
    familyDetailCompleted = json['family_detail_completed'];
    otherDetailCompleted = json['other_detail_completed'];
    basicDetail = json['basic_detail'] != null ? BasicDetail.fromJson(json['basic_detail']) : null;
    familyDetail = json['family_detail'] != null ? FamilyDetail.fromJson(json['family_detail']) : null;
    otherDetail = json['other_detail'] != null ? OtherDetail.fromJson(json['other_detail']) : null;
    photosCompleted = json['photos_completed'];
    indexNumber = json['index_number'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    sortlisted = json['sortlisted'];
    blocked = json['blocked'];
    viewedMyBiodataCount = json['viewed_my_biodata_count'];
    shortListMyBioDataCount = json['short_list_my_bio_data_count'];
    age = json['age'];
  }

  bool? basicDetailCompleted;
  bool? familyDetailCompleted;
  bool? otherDetailCompleted;
  BasicDetail? basicDetail;
  FamilyDetail? familyDetail;
  OtherDetail? otherDetail;
  bool? photosCompleted;
  String? indexNumber;
  List<Photos>? photos;
  String? status;
  String? message;
  bool? sortlisted;
  bool? blocked;
  int? viewedMyBiodataCount;
  int? shortListMyBioDataCount;
  String? age;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['basic_detail_completed'] = basicDetailCompleted;
    data['family_detail_completed'] = familyDetailCompleted;
    data['other_detail_completed'] = otherDetailCompleted;
    if (basicDetail != null) {
      data['basic_detail'] = basicDetail!.toJson();
    }
    if (familyDetail != null) {
      data['family_detail'] = familyDetail!.toJson();
    }
    if (otherDetail != null) {
      data['other_detail'] = otherDetail!.toJson();
    }
    data['photos_completed'] = photosCompleted;
    data['index_number'] = indexNumber;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    data['sortlisted'] = sortlisted;
    data['blocked'] = blocked;
    data['viewed_my_biodata_count'] = viewedMyBiodataCount;
    data['short_list_my_bio_data_count'] = shortListMyBioDataCount;
    data['age'] = age;
    return data;
  }
}

class BasicDetail {
  BasicDetail({
    this.username,
    this.subcaste,
    this.mobile,
    this.countryCode,
    this.satapeta,
    this.birthtime,
    this.maritalStatus,
    this.income,
    this.profilePhotoUrl,
  });

  BasicDetail.fromJson(dynamic json) {
    username = json['username'];
    subcaste = json['subcaste'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    satapeta = json['satapeta'];
    birthtime = json['birthtime'];
    maritalStatus = json['marital_status'];
    income = json['income'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  String? profilePhotoUrl;
  String? username;
  String? subcaste;
  String? mobile;
  String? countryCode;
  String? satapeta;
  String? birthtime;
  String? maritalStatus;
  String? income;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['subcaste'] = subcaste;
    data['mobile'] = mobile;
    data['country_code'] = countryCode;
    data['satapeta'] = satapeta;
    data['birthtime'] = birthtime;
    data['marital_status'] = maritalStatus;
    data['income'] = income;
    return data;
  }
}

class FamilyDetail {
  FamilyDetail(
      {this.fatherName,
      this.motherName,
      this.fatherOccupation,
      this.motherOccupation,
      this.fatherIncome,
      this.noOfMarriedBrother,
      this.noOfUnmarriedBrother,
      this.noOfMarriedSister,
      this.noOfUnmarriedSister});

  FamilyDetail.fromJson(dynamic json) {
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    fatherOccupation = json['father_occupation'];
    motherOccupation = json['mother_occupation'];
    fatherIncome = json['father_income'];
    noOfMarriedBrother = json['no_of_married_brother'];
    noOfUnmarriedBrother = json['no_of_unmarried_brother'];
    noOfMarriedSister = json['no_of_married_sister'];
    noOfUnmarriedSister = json['no_of_unmarried_sister'];
  }

  String? fatherName;
  String? motherName;
  String? fatherOccupation;
  String? motherOccupation;
  String? fatherIncome;
  String? noOfMarriedBrother;
  String? noOfUnmarriedBrother;
  String? noOfMarriedSister;
  String? noOfUnmarriedSister;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['father_occupation'] = fatherOccupation;
    data['mother_occupation'] = motherOccupation;
    data['father_income'] = fatherIncome;
    data['no_of_married_brother'] = noOfMarriedBrother;
    data['no_of_unmarried_brother'] = noOfUnmarriedBrother;
    data['no_of_married_sister'] = noOfMarriedSister;
    data['no_of_unmarried_sister'] = noOfUnmarriedSister;
    return data;
  }
}

class OtherDetail {
  OtherDetail(
      {this.specificNote,
      this.fatherWhatsappMobileNo,
      this.nriVisaTypeId,
      this.visaName,
      this.email,
      this.fatherMobileCountryCode,
      this.fatherMobileWhatsappCountryCode});

  OtherDetail.fromJson(dynamic json) {
    specificNote = json['specific_note'];
    fatherWhatsappMobileNo = json['father_whatsapp_mobile_no'];
    nriVisaTypeId = json['nri_visa_type_id'];
    visaName = json['visa_name'];
    email = json['email'];
    fatherMobileCountryCode = json['father_mobile_country_code'];
    fatherMobileWhatsappCountryCode = json['father_mobile_whatsapp_country_code'];
  }

  String? specificNote;
  Null? fatherWhatsappMobileNo;
  Null? nriVisaTypeId;
  Null? visaName;
  String? email;
  Null? fatherMobileCountryCode;
  Null? fatherMobileWhatsappCountryCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['specific_note'] = specificNote;
    data['father_whatsapp_mobile_no'] = fatherWhatsappMobileNo;
    data['nri_visa_type_id'] = nriVisaTypeId;
    data['visa_name'] = visaName;
    data['email'] = email;
    data['father_mobile_country_code'] = fatherMobileCountryCode;
    data['father_mobile_whatsapp_country_code'] = fatherMobileWhatsappCountryCode;
    return data;
  }
}

class Photos {
  Photos({this.id, this.url});

  Photos.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
  }

  String? id;
  String? url;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}
