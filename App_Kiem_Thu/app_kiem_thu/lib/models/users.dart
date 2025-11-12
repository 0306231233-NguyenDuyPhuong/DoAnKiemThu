class User {
  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? birthDate;
  String? image;
  Address? address;
  String? macAddress;
  String? university;
  String? role;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.address,
    this.macAddress,
    this.university,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    maidenName: json["maidenName"] ?? "",
    age: json["age"] ?? 0,
    gender: json["gender"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    username: json["username"] ?? "",
    password: json["password"] ?? "",
    birthDate: json["birthDate"] ?? "",
    image: json["image"] ?? "",
    address: json["address"] != null
        ? Address.fromJson(json["address"])
        : null,
    macAddress: json["macAddress"] ?? "",
    university: json["university"] ?? "",
    role: json["role"] ?? "",
  );

  Map<String, dynamic> toJson() => {

    "username": username,
    "password": password,

  };
}

class Address {
  String? address;
  String? city;
  String? state;
  String? stateCode;
  String? postalCode;
  Coordinates? coordinates;
  String? country;

  Address({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"] ?? "",
    city: json["city"] ?? "",
    state: json["state"] ?? "",
    stateCode: json["stateCode"] ?? "",
    postalCode: json["postalCode"] ?? "",
    coordinates: json["coordinates"] != null
        ? Coordinates.fromJson(json["coordinates"])
        : null,
    country: json["country"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "state": state,
    "stateCode": stateCode,
    "postalCode": postalCode,
    "coordinates": coordinates?.toJson(),
    "country": country,
  };
}


class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    lat: (json["lat"] as num?)?.toDouble(),
    lng: (json["lng"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};
}

