class Location {
  List<Data>? data;
  bool? error;

  Location({this.data, this.error});

  Location.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? travelId;
  String? travelAppId;
  String? travelAppUserId;
  String? travelCat;
  String? travelType;
  String? travelName;
  String? travelDetail;
  String? travelLat;
  String? travelLng;
  String? travelAddress;
  String? travelPhone;
  String? travelEmail;
  String? travelFacebook;
  String? travelLine;
  String? travelUpdateDate;
  String? travelCreateDate;
  Null? travelImages;

  Data(
      {this.travelId,
      this.travelAppId,
      this.travelAppUserId,
      this.travelCat,
      this.travelType,
      this.travelName,
      this.travelDetail,
      this.travelLat,
      this.travelLng,
      this.travelAddress,
      this.travelPhone,
      this.travelEmail,
      this.travelFacebook,
      this.travelLine,
      this.travelUpdateDate,
      this.travelCreateDate,
      this.travelImages});

  Data.fromJson(Map<String, dynamic> json) {
    travelId = json['travel_id'];
    travelAppId = json['travel_app_id'];
    travelAppUserId = json['travel_app_user_id'];
    travelCat = json['travel_cat'];
    travelType = json['travel_type'];
    travelName = json['travel_name'];
    travelDetail = json['travel_detail'];
    travelLat = json['travel_lat'];
    travelLng = json['travel_lng'];
    travelAddress = json['travel_address'];
    travelPhone = json['travel_phone'];
    travelEmail = json['travel_email'];
    travelFacebook = json['travel_facebook'];
    travelLine = json['travel_line'];
    travelUpdateDate = json['travel_update_date'];
    travelCreateDate = json['travel_create_date'];
    travelImages = json['travel_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travel_id'] = this.travelId;
    data['travel_app_id'] = this.travelAppId;
    data['travel_app_user_id'] = this.travelAppUserId;
    data['travel_cat'] = this.travelCat;
    data['travel_type'] = this.travelType;
    data['travel_name'] = this.travelName;
    data['travel_detail'] = this.travelDetail;
    data['travel_lat'] = this.travelLat;
    data['travel_lng'] = this.travelLng;
    data['travel_address'] = this.travelAddress;
    data['travel_phone'] = this.travelPhone;
    data['travel_email'] = this.travelEmail;
    data['travel_facebook'] = this.travelFacebook;
    data['travel_line'] = this.travelLine;
    data['travel_update_date'] = this.travelUpdateDate;
    data['travel_create_date'] = this.travelCreateDate;
    data['travel_images'] = this.travelImages;
    return data;
  }
}
