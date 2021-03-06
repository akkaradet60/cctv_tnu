import 'dart:convert';

import 'package:cctv_tun/models/model/product.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  static Future<List<product>> getBooks(String query) async {
    final url = (Global.urlWeb +
        'api/app/otop/search-product/restful/?product_app_id=${Global.app_id}');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
    });
    if (response.statusCode == 200) {
      final List search = json.decode(response.body);

      return search.map((json) => product.fromJson(json)).where((search) {
        final titleLower = search.title.toLowerCase();
        final authorLower = search.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

// class BooksApi1 {
//   static get books => null;

//   static Future<Map<String, dynamic>> getBooks(String query) async {
//     late Map<String, dynamic> imgSlide;
//     final url = (Global.urlWeb +
//         'api/app/blog/restful/?blog_app_id=${Global.app_id}&blog_cat_id=${Global.glog_catid}');
//     final response = await http.get(Uri.parse(url), headers: {
//       'Authorization':
//           'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
//     });

//     if (response.statusCode == 200) {
//       final List imgSlide = json.decode(response.body);

//       return books.map((json) => product.fromJson(json)).where((book) {
//         final titleLower = book.title.toLowerCase();
//         final authorLower = book.author.toLowerCase();
//         final searchLower = query.toLowerCase();

//         return titleLower.contains(searchLower) ||
//             authorLower.contains(searchLower);
//       }).toList();
//     } else {
//       throw Exception('$response.statusCode');
//     }
//   }
// }
