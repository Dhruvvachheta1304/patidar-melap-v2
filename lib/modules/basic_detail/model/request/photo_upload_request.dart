class PhotoUploadRequest {
  PhotoUploadRequest({this.profilePhotos, this.userAgent});

  PhotoUploadRequest.fromJson(dynamic json) {
    profilePhotos = json['profile_photos'];
    userAgent = json['user_agent'];
  }

  String? profilePhotos;
  String? userAgent;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['profile_photos'] = profilePhotos;
    data['user_agent'] = userAgent;
    return data;
  }
}
