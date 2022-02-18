class product_store {
  final String otop_name;
  final String otop_dateil;
  final String otop_lat;
  final String otop_lng;
  final String otop_phone;
  final String otop_start_date;
  final String otop_end_date;
  final String otop_product_time;
  final String otop_image;
  final String otop_id;

  const product_store({
    required this.otop_name,
    required this.otop_dateil,
    required this.otop_lat,
    required this.otop_lng,
    required this.otop_phone,
    required this.otop_start_date,
    required this.otop_end_date,
    required this.otop_product_time,
    required this.otop_image,
    required this.otop_id,
  });

  factory product_store.fromJson(Map<String, dynamic> json) => product_store(
        otop_name: json['otop_name'],
        otop_dateil: json['otop_dateil'],
        otop_lat: json['otop_lat'],
        otop_lng: json['otop_lng'],
        otop_phone: json['otop_phone'],
        otop_start_date: json['otop_start_date'],
        otop_end_date: json['otop_end_date'],
        otop_product_time: json['otop_product_time'],
        otop_image: json['otop_image'],
        otop_id: json['otop_id'],
      );

  Map<String, dynamic> toJson() => {
        'otop_name': otop_name,
        'otop_dateil': otop_dateil,
        'otop_lat': otop_lat,
        'otop_lng': otop_lng,
        'otop_phone': otop_phone,
        'otop_start_date': otop_start_date,
        'otop_end_date': otop_end_date,
        'otop_product_time': otop_product_time,
        'otop_image': otop_image,
        'otop_id': otop_id,
      };
}

// class Booxx {
//   List<Data>? data;
//   bool? error;

//   Booxx({this.data, this.error});

//   Booxx.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     error = json['error'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['error'] = this.error;
//     return data;
//   }
// }

// class Data {
//   String? blogId;
//   String? blogName;
//   String? blogDetail;
//   String? blogView;
//   String? blogUpdateDate;
//   List<BlogImages>? blogImages;

//   Data(
//       {this.blogId,
//       this.blogName,
//       this.blogDetail,
//       this.blogView,
//       this.blogUpdateDate,
//       this.blogImages});

//   Data.fromJson(Map<String, dynamic> json) {
//     blogId = json['blog_id'];
//     blogName = json['blog_name'];
//     blogDetail = json['blog_detail'];
//     blogView = json['blog_view'];
//     blogUpdateDate = json['blog_update_date'];
//     if (json['blog_images'] != null) {
//       blogImages = <BlogImages>[];
//       json['blog_images'].forEach((v) {
//         blogImages!.add(new BlogImages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['blog_id'] = this.blogId;
//     data['blog_name'] = this.blogName;
//     data['blog_detail'] = this.blogDetail;
//     data['blog_view'] = this.blogView;
//     data['blog_update_date'] = this.blogUpdateDate;
//     if (this.blogImages != null) {
//       data['blog_images'] = this.blogImages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class BlogImages {
//   String? blogiId;
//   String? blogiBlogId;
//   String? blogiPathName;
//   String? blogiUpdateDate;
//   String? blogiCreateDate;

//   BlogImages(
//       {this.blogiId,
//       this.blogiBlogId,
//       this.blogiPathName,
//       this.blogiUpdateDate,
//       this.blogiCreateDate});

//   BlogImages.fromJson(Map<String, dynamic> json) {
//     blogiId = json['blogi_id'];
//     blogiBlogId = json['blogi_blog_id'];
//     blogiPathName = json['blogi_path_name'];
//     blogiUpdateDate = json['blogi_update_date'];
//     blogiCreateDate = json['blogi_create_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['blogi_id'] = this.blogiId;
//     data['blogi_blog_id'] = this.blogiBlogId;
//     data['blogi_path_name'] = this.blogiPathName;
//     data['blogi_update_date'] = this.blogiUpdateDate;
//     data['blogi_create_date'] = this.blogiCreateDate;
//     return data;
//   }
// }
