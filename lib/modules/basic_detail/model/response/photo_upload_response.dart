class PhotoUploadResponse {
  PhotoUploadResponse({
    this.status,
    this.message,
    this.data,
  });

  PhotoUploadResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? PhotoData.fromJson(json['data']) : null;
  }

  String? status;
  String? message;
  PhotoData? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PhotoData {
  PhotoData({this.url, this.id});

  PhotoData.fromJson(dynamic json) {
    url = json['url'];
    id = json['id'];
  }

  String? url;
  String? id;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['id'] = id;
    return data;
  }
}
