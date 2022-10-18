import 'dart:convert';

import 'package:dio/dio.dart';

class ZipCode{
  static Future<String?>? addressFromZipCode(String code)async{
    try{
      Dio dio = Dio();
      var mainUrl = "https://zipcloud.ibsnet.co.jp/api/search";
      var res = await dio.get(
          mainUrl,
          queryParameters: {
            "zipcode" : code
          }
      );
      var results = jsonDecode(res.data)["results"][0];
      var address1 = results["address1"];
      var address2 = results["address2"];
      var address3 = results["address3"];
      var address = address1+address2+address3;
      print(address);
      return address;
    }catch(e){
      return null;
    }
  }
}
