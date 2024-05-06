class CasteModel {
  CasteModel({
    this.casteDataList,
    this.totalRows,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.pagination,
  });

  CasteModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      casteDataList = <CasteData>[];
      json['data'].forEach((v) {
        casteDataList!.add(CasteData.fromJson(v));
      });
    }
    totalRows = json['total_rows'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    pagination = json['pagination'];
  }

  List<CasteData>? casteDataList;
  int? totalRows;
  int? currentPage;
  int? lastPage;
  int? perPage;
  String? pagination;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (casteDataList != null) {
      data['data'] = casteDataList!.map((v) => v.toJson()).toList();
    }
    data['total_rows'] = totalRows;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['pagination'] = pagination;
    return data;
  }
}

class CasteData {
  CasteData({
    this.id,
    this.status,
    this.religionId,
    this.casteName,
    this.isOther,
    this.isDeleted,
  });

  CasteData.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    religionId = json['religion_id'];
    casteName = json['caste_name'];
    isOther = json['is_other'];
    isDeleted = json['is_deleted'];
  }

  String? id;
  String? status;
  String? religionId;
  String? casteName;
  String? isOther;
  String? isDeleted;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['religion_id'] = religionId;
    data['caste_name'] = casteName;
    data['is_other'] = isOther;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
