class Blog {
  Blog({
    required this.data,
    required this.error,
  });
  late final List<Data> data;
  late final bool error;

  Blog.fromJson(Map<String, dynamic> json) {
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
    required this.blogiPathName,
    // this.blogiPathName,
    required this.blogUpdateDate,
  });
  late final String blogId;
  late final String blogName;
  late final String blogDetail;
  late final String? blogiPathName;
  late final String blogUpdateDate;

  Data.fromJson(Map<String, dynamic> json) {
    blogId = json['blog_id'] ?? 0;
    blogName = json['blog_name'] ?? 'No Data';
    blogDetail = json['blog_detail'] ?? 'No Data';
    blogiPathName = json['blogi_path_name'] ??
        'https://boychawin.com/B_images/logoboychawins.com.png';
    blogUpdateDate = json['blog_update_date'] ?? 'No Data';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['blog_id'] = blogId;
    _data['blog_name'] = blogName;
    _data['blog_detail'] = blogDetail;
    _data['blogi_path_name'] = blogiPathName;
    _data['blog_update_date'] = blogUpdateDate;
    return _data;
  }
}
