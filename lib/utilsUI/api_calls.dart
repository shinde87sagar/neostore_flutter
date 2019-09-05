import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:neostore/constants/urls.dart';

class ApiCalls {

  static Future<dynamic> _get(String url) async {
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  static Future<dynamic> _post(String url, Map postData) async {
    try {
      final response = await http.post(url, headers : {},body : postData);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch(exp){
      return null;
    }
  }

  static Future<dynamic> getUserList() async {
    return await _get('${Urls.baseUrl}/${Urls.login}');
  }

  static Future<dynamic> loginUser(postData) async{
    var obj = await _post("${Urls.baseUrl}${Urls.login}",postData);
    return obj;
  }


  postData(postData,partUrl) async {
    try {
      
      var response = await http.post(
        Uri.encodeFull(Urls.baseUrl+partUrl),
        headers: {"Accept": "application/json"},
        body: postData,
      );
      return jsonDecode(response.body);
    } catch (error) {
      return null;     
    }
  }

  // static loginUser(postData) async{
  //   print(postData);
  //   var obj = await postData(postData,Urls.login);
  //   print(obj);
  //   return obj;
  // }

  static Future<dynamic>categoryimages() async {
    return await _get('${Urls.baseUrl}${Urls.categoryImages}');
  }

  static Future<dynamic>getProducts(categoryId) async {
    print(categoryId);
    return await _get('${Urls.baseUrl}${Urls.findProducts}?category_id=$categoryId');
  }
}