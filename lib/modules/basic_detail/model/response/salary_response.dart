class SalaryModel {
  SalaryModel({this.SalaryDataList});

  SalaryModel.fromJson(dynamic json) {
    SalaryDataList = json['data'] != null ? SalaryData.fromJson(json['data']) : null;
  }

  SalaryData? SalaryDataList;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.SalaryDataList != null) {
      data['data'] = this.SalaryDataList!.toJson();
    }
    return data;
  }
}

class SalaryData {
  SalaryData({this.salarylist, this.currencylist});

  SalaryData.fromJson(dynamic json) {
    if (json['salarylist'] != null) {
      salarylist = <Salarylist>[];
      json['salarylist'].forEach((v) {
        salarylist!.add(Salarylist.fromJson(v));
      });
    }
    if (json['currencylist'] != null) {
      currencylist = <Currencylist>[];
      json['currencylist'].forEach((v) {
        currencylist!.add(Currencylist.fromJson(v));
      });
    }
  }

  List<Salarylist>? salarylist;
  List<Currencylist>? currencylist;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (salarylist != null) {
      data['salarylist'] = salarylist!.map((v) => v.toJson()).toList();
    }
    if (currencylist != null) {
      data['currencylist'] = currencylist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Salarylist {
  Salarylist({this.salary});

  Salarylist.fromJson(dynamic json) {
    salary = json['salary'];
  }

  String? salary;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['salary'] = salary;
    return data;
  }
}

class Currencylist {
  Currencylist({this.id, this.currency});

  Currencylist.fromJson(dynamic json) {
    id = json['id'];
    currency = json['currency'];
  }

  String? id;
  String? currency;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['currency'] = currency;
    return data;
  }
}
