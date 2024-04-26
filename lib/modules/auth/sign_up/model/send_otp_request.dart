class SendOtpRequest {
  SendOtpRequest({this.status, this.code});

  SendOtpRequest.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
  }

  String? status;
  int? code;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    return data;
  }
}
