


class AppUserInfo {
  String? userId;
  String? name;
  String? email;
  String? phoneNumber;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory AppUserInfo.fromJson(Map<String, dynamic> map) {
    return AppUserInfo(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  AppUserInfo({
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
  });
}