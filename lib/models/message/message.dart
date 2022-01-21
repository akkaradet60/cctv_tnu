class Messages {
  Messages({
    required this.data,
    required this.error,
  });
  late final List<Data> data;
  late final bool error;

  Messages.fromJson(Map<String, dynamic> json) {
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
    required this.blogId,
    required this.blogName,
    required this.blogDetail,
    required this.blogUpdateDate,
    this.blogImages,
  });
  late final String blogId;
  late final String blogName;
  late final String blogDetail;
  late final String blogUpdateDate;
  late final List<BlogImages>? blogImages;

  Data.fromJson(Map<String, dynamic> json) {
    blogId = json['blog_id'];
    blogName = json['blog_name'];
    blogDetail = json['blog_detail'];
    blogUpdateDate = json['blog_update_date'];
    blogImages = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['blog_id'] = blogId;
    _data['blog_name'] = blogName;
    _data['blog_detail'] = blogDetail;
    _data['blog_update_date'] = blogUpdateDate;
    _data['blog_images'] = blogImages;
    return _data;
  }
}

class BlogImages {
  BlogImages({
    required this.blogiId,
    required this.blogiBlogId,
    required this.blogiPathName,
    required this.blogiUpdateDate,
    required this.blogiCreateDate,
  });
  late final String blogiId;
  late final String blogiBlogId;
  late final String blogiPathName;
  late final String blogiUpdateDate;
  late final String blogiCreateDate;

  BlogImages.fromJson(Map<String, dynamic> json) {
    blogiId = json['blogi_id'];
    blogiBlogId = json['blogi_blog_id'];
    blogiPathName = json['blogi_path_name'];
    blogiUpdateDate = json['blogi_update_date'];
    blogiCreateDate = json['blogi_create_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['blogi_id'] = blogiId;
    _data['blogi_blog_id'] = blogiBlogId;
    _data['blogi_path_name'] = blogiPathName;
    _data['blogi_update_date'] = blogiUpdateDate;
    _data['blogi_create_date'] = blogiCreateDate;
    return _data;
  }
}
