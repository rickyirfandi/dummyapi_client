import 'package:dummyapi_client/const/color.dart';
import 'package:dummyapi_client/const/text_style.dart';
import 'package:dummyapi_client/data/models/post/post.dart';
import 'package:dummyapi_client/data/repository/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardPost extends StatefulWidget {
  final Post post;

  const CardPost({Key? key, required this.post}) : super(key: key);

  @override
  State<CardPost> createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  PostRepository repo = PostRepository();

  Widget user() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.post.owner.picture),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.post.owner.getFullName(),
                style: reguler18.copyWith(color: kPrimaryColor),
              ),
              Text(
                widget.post.getPublishDate(),
                style: reguler14.copyWith(color: kPrimaryColor),
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user(),
          Container(
            height: screen.height * 0.25,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  widget.post.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    for (int x = 0; x < widget.post.tags.length; x++)
                      GestureDetector(
                        onTap: () {
                          PostRepository.filter.value = widget.post.tags[x];
                          PostRepository.postPage = -1;
                          PostRepository.postList.clear();
                          repo.getPost();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Chip(
                            backgroundColor: kPrimaryColor,
                            label: Text(
                              widget.post.tags[x],
                              style: reguler15.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.post.text,
                  style: reguler16.copyWith(color: kPrimaryColor),
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
