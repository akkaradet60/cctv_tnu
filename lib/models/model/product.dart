// class Book {
//   String? id;
//   String? title;
//   String? author;
//   Null urlImage;

//   Book({this.id, this.title, this.author, this.urlImage});

//   Book.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     author = json['author'];
//     urlImage = json['urlImage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['author'] = this.author;
//     data['urlImage'] = this.urlImage;
//     return data;
//   }
// }

class product {
  final String id;
  final String title;
  final String author;
  final String urlImage;
  final String product_number;
  final String product_detail;
  final String product_price;
  final String product_discount;

  const product({
    required this.id,
    required this.author,
    required this.title,
    required this.urlImage,
    required this.product_number,
    required this.product_detail,
    required this.product_price,
    required this.product_discount,
  });

  factory product.fromJson(Map<String, dynamic> json) => product(
        id: json['id'],
        author: json['author'],
        title: json['title'],
        urlImage: json['urlImage'],
        product_detail: json['product_detail'],
        product_number: json['product_number'],
        product_price: json['product_price'],
        product_discount: json['product_discount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'urlImage': urlImage,
        'product_detail': product_detail,
        'product_number': product_number,
        'product_price': product_price,
        'product_discount': product_discount,
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
