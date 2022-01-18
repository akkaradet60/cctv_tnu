// class BestSeller {
//   BestSeller({
//     required this.data,
//     required this.error,
//   });
//   late final List<Data> data;
//   late final bool error;

//   BestSeller.fromJson(Map<String, dynamic> json) {
//     data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
//     error = json['error'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     _data['error'] = error;
//     return _data;
//   }
// }

// class Data {
//   Data({
//     required this.productId,
//     required this.productOtopId,
//     required this.productCatagoryId,
//     required this.productName,
//     required this.productDetail,
//     required this.productNumber,
//     required this.productPrice,
//     required this.productDiscount,
//     this.productDataView,
//     required this.productCountView,
//     required this.productUpdateDate,
//     required this.productCreateDate,
//     this.productImage,
//   });
//   late final String productId;
//   late final String productOtopId;
//   late final String productCatagoryId;
//   late final String productName;
//   late final String productDetail;
//   late final String productNumber;
//   late final String productPrice;
//   late final String productDiscount;
//   late final Null productDataView;
//   late final String productCountView;
//   late final String productUpdateDate;
//   late final String productCreateDate;
//   late final List<ProductImage>? productImage;

//   Data.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     productOtopId = json['product_otop_id'];
//     productCatagoryId = json['product_catagory_id'];
//     productName = json['product_name'];
//     productDetail = json['product_detail'];
//     productNumber = json['product_number'];
//     productPrice = json['product_price'];
//     productDiscount = json['product_discount'];
//     productDataView = null;
//     productCountView = json['product_count_view'];
//     productUpdateDate = json['product_update_date'];
//     productCreateDate = json['product_create_date'];
//     productImage = null;
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_otop_id'] = productOtopId;
//     _data['product_catagory_id'] = productCatagoryId;
//     _data['product_name'] = productName;
//     _data['product_detail'] = productDetail;
//     _data['product_number'] = productNumber;
//     _data['product_price'] = productPrice;
//     _data['product_discount'] = productDiscount;
//     _data['product_data_view'] = productDataView;
//     _data['product_count_view'] = productCountView;
//     _data['product_update_date'] = productUpdateDate;
//     _data['product_create_date'] = productCreateDate;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }

// class ProductImage {
//   ProductImage({
//     required this.productiId,
//     required this.productiProductId,
//     required this.productiPathName,
//     required this.productiUpdateDate,
//     required this.productiCreateDate,
//   });
//   late final String productiId;
//   late final String productiProductId;
//   late final String productiPathName;
//   late final String productiUpdateDate;
//   late final String productiCreateDate;

//   ProductImage.fromJson(Map<String, dynamic> json) {
//     productiId = json['producti_id'];
//     productiProductId = json['producti_product_id'];
//     productiPathName = json['producti_path_name'];
//     productiUpdateDate = json['producti_update_date'];
//     productiCreateDate = json['producti_create_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['producti_id'] = productiId;
//     _data['producti_product_id'] = productiProductId;
//     _data['producti_path_name'] = productiPathName;
//     _data['producti_update_date'] = productiUpdateDate;
//     _data['producti_create_date'] = productiCreateDate;
//     return _data;
//   }
// }
class BestSeller {
  List<Data>? data;
  bool? error;

  BestSeller({this.data, this.error});

  BestSeller.fromJson(Map<String, dynamic> json) {
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
  String? productId;
  String? productOtopId;
  String? productCatagoryId;
  String? productName;
  String? productDetail;
  String? productNumber;
  String? productPrice;
  String? productDiscount;
  Null? productDataView;
  String? productCountView;
  String? productUpdateDate;
  String? productCreateDate;
  List<ProductImage>? productImage;

  Data(
      {this.productId,
      this.productOtopId,
      this.productCatagoryId,
      this.productName,
      this.productDetail,
      this.productNumber,
      this.productPrice,
      this.productDiscount,
      this.productDataView,
      this.productCountView,
      this.productUpdateDate,
      this.productCreateDate,
      this.productImage});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productOtopId = json['product_otop_id'];
    productCatagoryId = json['product_catagory_id'];
    productName = json['product_name'];
    productDetail = json['product_detail'];
    productNumber = json['product_number'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productDataView = json['product_data_view'];
    productCountView = json['product_count_view'];
    productUpdateDate = json['product_update_date'];
    productCreateDate = json['product_create_date'];
    if (json['product_images'] != null) {
      productImage = <ProductImage>[];
      json['product_images'].forEach((v) {
        productImage!.add(new ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_otop_id'] = this.productOtopId;
    data['product_catagory_id'] = this.productCatagoryId;
    data['product_name'] = this.productName;
    data['product_detail'] = this.productDetail;
    data['product_number'] = this.productNumber;
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_data_view'] = this.productDataView;
    data['product_count_view'] = this.productCountView;
    data['product_update_date'] = this.productUpdateDate;
    data['product_create_date'] = this.productCreateDate;
    if (this.productImage != null) {
      data['product_image'] =
          this.productImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImage {
  String? productiId;
  String? productiProductId;
  String? productiPathName;
  String? productiUpdateDate;
  String? productiCreateDate;

  ProductImage(
      {this.productiId,
      this.productiProductId,
      this.productiPathName,
      this.productiUpdateDate,
      this.productiCreateDate});

  ProductImage.fromJson(Map<String, dynamic> json) {
    productiId = json['producti_id'];
    productiProductId = json['producti_product_id'];
    productiPathName = json['producti_path_name'];
    productiUpdateDate = json['producti_update_date'];
    productiCreateDate = json['producti_create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['producti_id'] = this.productiId;
    data['producti_product_id'] = this.productiProductId;
    data['producti_path_name'] = this.productiPathName;
    data['producti_update_date'] = this.productiUpdateDate;
    data['producti_create_date'] = this.productiCreateDate;
    return data;
  }
}
