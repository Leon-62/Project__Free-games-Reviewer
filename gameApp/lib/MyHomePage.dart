import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game1_app/Config.dart';

import 'DetailPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('推荐'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailPage(index);
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Config.gammeNameList[index]),
                        SizedBox(height: 10),
                        Text(Config.gammeContentList[index]),
                      ],
                    ),
                  ));
            },
            itemCount: Config.gammeNameList.length),
      ),
    );
  }
}
