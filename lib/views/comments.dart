import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/comment_save.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/comment_repository.dart';
import 'package:polar_sun/data/repositories/comment_save_repository.dart';

import '../data/entities/comment.dart';
import '../data/entities/plant.dart';

class Comments extends StatefulWidget {
  final AuthorizedUser user;
  final Plant plant;

  const Comments({Key? key, required this.user, required this.plant})
      : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var commentRepository = CommentRepository();
  CommentSaveRepository commentSaveRepository = CommentSaveRepository();

  final Map<String, String> queryParams = {};
  List<Comment> comments = [];

  Future<void> getData(Map<String, String> queryParams) async {
    comments = await commentRepository.getAll(
        queryParams: queryParams, user: widget.user);
    setState(() {});
  }

  addToDatabase() {
    if (commentController.text.length > 1) {
      CommentSave commentSave = CommentSave(
          text: commentController.text,
          user: widget.user.id,
          plant: widget.plant.id);
      commentSaveRepository.create(commentSave, widget.user);
    }
    Future.delayed(Duration(seconds: 1)).then((value) => getData(queryParams));


  }

  Widget commentsView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white38),
            child: Row(
              children: [Text(comments[i].text)],
            ),
          );
        });
  }

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    queryParams["plant"] = widget.plant.id.toString();
    getData(queryParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Комментарии к " + widget.plant.name),
      ),
      body: ListView(children: [
        SizedBox(height: 40,),
        commentsView(),
        if (widget.user.role == "subs" || widget.user.role == "moder")
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(label: Text("Напишите комментарий")),
            ),
          ),
        if (widget.user.role == "subs" || widget.user.role == "moder")
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 2, 10, MediaQuery.of(context).size.width / 4, 0),
            child: ElevatedButton(
                onPressed: addToDatabase,
                child: Text(
                  "Отправить комментарий",
                  style: TextStyle(color: Colors.white70),
                )),
          )
      ]),
    );
  }
}
