class Manuals {
  Manuals({
    required this.data,
    required this.error,
  });
  late final List<Data> data;
  late final bool error;

  Manuals.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['error'] = error;
    return _data;
  }
}

class Data {
  Data({
    required this.manualId,
    required this.manualUserId,
    required this.manualCat,
    required this.manualName,
    required this.manualDetail,
    required this.manualPathName,
    required this.manualUpdateDate,
    required this.manualCreateDate,
  });
  late final String manualId;
  late final String manualUserId;
  late final String manualCat;
  late final String manualName;
  late final String manualDetail;
  late final String manualPathName;
  late final String manualUpdateDate;
  late final String manualCreateDate;

  Data.fromJson(Map<String, dynamic> json) {
    manualId = json['manual_id'];
    manualUserId = json['manual_user_id'];
    manualCat = json['manual_cat'];
    manualName = json['manual_name'];
    manualDetail = json['manual_detail'];
    manualPathName = json['manual_path_name'];
    manualUpdateDate = json['manual_update_date'];
    manualCreateDate = json['manual_create_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['manual_id'] = manualId;
    _data['manual_user_id'] = manualUserId;
    _data['manual_cat'] = manualCat;
    _data['manual_name'] = manualName;
    _data['manual_detail'] = manualDetail;
    _data['manual_path_name'] = manualPathName;
    _data['manual_update_date'] = manualUpdateDate;
    _data['manual_create_date'] = manualCreateDate;
    return _data;
  }
}
