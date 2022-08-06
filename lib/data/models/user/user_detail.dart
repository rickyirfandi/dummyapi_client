import 'package:dummyapi_client/data/models/user/user_location.dart';

class UserData {
  late String id;
  late String title;
  late String firstName;
  late String lastName;
  late String picture;
  late String gender;
  late String email;
  late DateTime dateOfBirth;
  late String phone;
  late UserLocation location;
  late DateTime registerDate;

  UserData._({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
    required this.gender,
    required this.email,
    required this.dateOfBirth,
    required this.location,
    required this.phone,
    required this.registerDate,
  });

  String getFullName() {
    return "$firstName $lastName";
  }

  String getBirthDate() {
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

    return "${dateOfBirth.day.toString()} ${bulan[dateOfBirth.month - 1]} ${dateOfBirth.year.toString()}";
  }

  String getJoinDate() {
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

    return "${registerDate.day.toString()} ${bulan[registerDate.month - 1]} ${registerDate.year.toString()}";
  }

  factory UserData.fromJSON(Map<String, dynamic> json) {
    return UserData._(
      id: json['id'].toString(),
      title: json['title'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      picture: json['picture'].toString(),
      gender: json['gender'].toString(),
      email: json['email'].toString(),
      dateOfBirth: DateTime.parse(json['dateOfBirth'].toString()),
      location: UserLocation.fromJSON(json['location']),
      phone: json['phone'].toString(),
      registerDate: DateTime.parse(json['registerDate'].toString()),
    );
  }
}
