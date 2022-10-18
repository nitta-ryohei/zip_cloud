import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zip_cloud/screens/zip_cloud.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String address = 'ここに住所が表示されます';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("郵便番号データベース"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Center(
                child: Text(
              "郵便番号入力フォーム",
              style: TextStyle(fontSize: 15.0),
            )),
            TextField(
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 20.0),
              controller: _textEditingController,

              ///todo controllerの変更
            ),
            const SizedBox(
              height: 50.0,
            ),
            Text(
              address,
              style: const TextStyle(fontSize: 24.0),
            ),
            Expanded(child: Image.asset("assets/images/mails.png")),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  address = await onClick() as String;
                  setState(() {});
                },
                child: const Text(
                  "検索",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(height: 30.0,)
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          onPressed: () async{
            address = await ZipCode.addressFromZipCode(_textEditingController.text) as String;
            setState(() {
            });
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }

  Future<String>? onClick() async {
    var inputText = _textEditingController.text;
    Dio dio = Dio();
    var mainUrl = "https://zipcloud.ibsnet.co.jp/api/search";
    var code = "?zipcode=";
    print(mainUrl + code + inputText);

    var res = await dio.get(mainUrl + code + inputText);

    // print(mainUrl + inputText);
    // print(jsonDecode(res.data));
    var address1 = jsonDecode(res.data)["results"][0]["address1"];
    var address2 = jsonDecode(res.data)["results"][0]["address2"];
    var address3 = jsonDecode(res.data)["results"][0]["address3"];
    print(address1 + address2 + address3);
    return address1 + address2 + address3;
    // return
  }
}
