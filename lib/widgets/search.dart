import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technologymedia/fullpost.dart';
import 'package:technologymedia/main.dart';
import 'package:technologymedia/post.dart';
import 'package:video_thumbnail_generator/video_thumbnail_generator.dart';

class Searchingpost extends StatefulWidget {
  @override
  Searchingpoststate createState() => Searchingpoststate();
}

class Searchingpoststate extends State<Searchingpost> {
  TextEditingController _controller = new TextEditingController();
  FirebaseFirestore _store = FirebaseFirestore.instance;
  List<Post> allproducts = [];
  var postmap = new Map();
  String search;
  Post p;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _store.collection('posts').get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        print(value.docs[i].data()['product name']);
        _store
            .collection('users')
            .doc(value.docs[i].data()['email'])
            .get()
            .then((value1) {
          _store
              .collection('posts')
              .doc(value.docs[i].data()['email'] +
                  ' ' +
                  value.docs[i].data()['product name'])
              .collection('likes')
              .doc(auth.currentUser.email)
              .get()
              .then((action) {
            setState(() {
              p = new Post(
                  productname: value.docs[i].data()['product name'],
                  caption: value.docs[i].data()['content'],
                  imageUrl: value.docs[i].data()['multimedia'],
                  comments: value.docs[i].data()['comments'],
                  uname: value1.data()['first name'],
                  udp: value1.data()['dp'],
                  like: value.docs[i].data()['like'],
                  dislike: value.docs[i].data()['dislike'],
                  document_name: value.docs[i].data()['email'] +
                      ' ' +
                      value.docs[i].data()['product name'],
                  action: action.data()['action'],
                  type: value.docs[i].data()['type']);
            });
            setState(() {
              postmap[p.productname] = p;
              allproducts.add(p);
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody(BuildContext context, int Key) {}
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              onChanged: (val) {
                setState(() {
                  search = val.toLowerCase();
                  postmap.forEach((key, value) {
                    Post temp = value;
                    print(temp.like);
                  });
                });
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _controller.clear()),
                  hintText: "Search"),
            ),
          ),
          ListView.builder(
              itemCount: postmap.length,
              itemBuilder: (BuildContext ctxt, int index) =>
                  buildBody(ctxt, index))
        ],
      )),
    );
  }
}
