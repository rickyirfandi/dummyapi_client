class UserLocation {
  late String street;
  late String city;
  late String state;
  late String country;
  late String timezone;

  UserLocation._({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  String address() {
    return "$country $state $city $street";
  }

  factory UserLocation.fromJSON(Map<String, dynamic> json) {
    return UserLocation._(
      street: json['street'].toString(),
      city: json['city'].toString(),
      state: json['state'].toString(),
      country: json['country'].toString(),
      timezone: json['timezone'].toString(),
    );
  }
}
