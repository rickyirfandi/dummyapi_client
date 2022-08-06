class User {
  late String id;
  late String title;
  late String firstName;
  late String lastName;
  late String picture;

  User._({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  String getFullName() {
    return "$firstName $lastName";
  }

  factory User.fromJSON(Map<String, dynamic> json) {
    return User._(
      id: json['id'].toString(),
      title: json['title'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      picture: json['picture'].toString(),
    );
  }
}
