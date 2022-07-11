import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game1_app/Config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'CommentBean.dart';
import 'CommentPage.dart';

class DetailPage extends StatefulWidget {
  int index;
  DetailPage(this.index);

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  int index = 0;
  DatabaseReference root_database_ref =
      FirebaseDatabase.instance.reference().child('game1');
  late DatabaseReference childRef;
  List<CommentBean> comments = [];
  List<CommentBean> showComments = [];

  @override
  void initState() {
    super.initState();
    index = widget.index;
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    childRef = root_database_ref.root();
    query();
  }

  query() async {
    EasyLoading.show();
    var result = (await childRef.once()).value;
    EasyLoading.dismiss();
    if (result != null) {
      if (result['comments'] != null) {
        showComments.clear();
        comments = CommentBean.decode(result['comments']);
        comments.forEach((element) {
          if (element.name == Config.gammeNameList[index]) {
            showComments.add(element);
          }
        });
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
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
          child: Column(
            children: [
              Text(Config.gammeNameList[index]),
              SizedBox(height: 10),
              Text(Config.gammeContentList[index]),
              SizedBox(height: 10),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('评论'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CommentPage(index);
                        })).then((value) {
                          if (value == 1) {
                            query();
                          }
                        });
                      },
                      child: Icon(Icons.edit))
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, i) {
                        return Container(
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
                              Text(showComments[i].datetime),
                              SizedBox(height: 10),
                              Text(showComments[i].content),
                            ],
                          ),
                        );
                      },
                      itemCount: showComments.length))
            ],
          )),
    );
  }
}
