import 'package:dummyapi_client/data/models/user/user.dart';

class Post {
  late String id;
  late String image;
  late String like;
  late List<String> tags;
  late String text;
  late DateTime publishDate;
  late User owner;

  Post._({
    required this.id,
    required this.image,
    required this.like,
    required this.tags,
    required this.text,
    required this.publishDate,
    required this.owner,
  });

  String getPublishDate() {
    var bulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];

    return "${publishDate.day.toString()} ${bulan[publishDate.month - 1]} ${publishDate.year.toString()} ${publishDate.hour.toString()}:${publishDate.minute.toString()}:${publishDate.second.toString()} ";
  }

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post._(
      id: json['id'].toString(),
      image: json['image'].toString(),
      like: json['like'].toString(),
      tags: List<String>.from(json["tags"]),
      text: json['text'].toString(),
      publishDate: DateTime.parse(json['publishDate'].toString()),
      owner: User.fromJSON(json['owner']),
    );
  }
}
