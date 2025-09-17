import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'apiconst.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List titles=[];

  getHeadings(String id) async {

    var request = http.Request('GET', Uri.parse('${UrlConstants.titleUrl}/${UrlConstants.titleType}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Map data = jsonDecode(await response.stream.bytesToString());
      print(data);
      titles.clear();
      List heading =data["productgroup"];
      for(int i=0;i<data.length;i++){

      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getHeadings('3');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'dfghjkl'),
              Tab(text: 'fghjk'),
              Tab(text: 'fghj'),
              Tab(text: 'fghj'),
              Tab(text: 'fghj'),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              Center(
                child: Text('ghjkl;'),
              ),
              Center(
                child: Text('ghjkl;'),
              ),
              Center(
                child: Text('ghjkl;'),
              ),
              Center(
                child: Text('ghjkl;'),
              ),
              Center(
                child: Text('ghjkl;'),
              ),
            ]
        ),
      ),
    );
  }
}