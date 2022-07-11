import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game1_app/Config.dart';
import 'package:firebase_database/firebase_database.dart';

import 'CommentBean.dart';

class CommentPage extends StatefulWidget {
  int index;
  CommentPage(this.index);

  @override
  State<CommentPage> createState() => CommentPageState();
}

class CommentPageState extends State<CommentPage> {
  int index = 0;
  TextEditingController controller = TextEditingController();
  DatabaseReference root_database_ref =
      FirebaseDatabase.instance.reference().child('game1');
  late DatabaseReference childRef;
  List<CommentBean> comments = [];

  @override
  void initState() {
    super.initState();
    index = widget.index;
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    childRef = root_database_ref.root();
    query();
  }

  query() async {
    var result = (await childRef.once()).value;
    if (result != null) {
      if (result['comments'] != null) {
        List<CommentBean> list = CommentBean.decode(result['comments']);
        comments.addAll(list);
      }
    }
  }

  submit() async {
    if (controller.text == '') {
      EasyLoading.showInfo('请输入评论内容');
      return;
    }
    EasyLoading.show();
    CommentBean bean = CommentBean(
        name: Config.gammeNameList[index],
        content: controller.text,
        datetime: DateTime.now().toString().substring(0, 19));
    comments.add(bean);
    await childRef.set({
      'comments': CommentBean.encode(comments),
    });
    EasyLoading.dismiss();
    EasyLoading.showSuccess('评论完成');
    Navigator.pop(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('评论'),
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
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: '请输入评论', border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () => submit(),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    alignment: Alignment.center,
                    child: Text('发送', style: TextStyle(color: Colors.white)),
                  )),
            ],
          )),
    );
  }
}
