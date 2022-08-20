


class UserInfo {
  String? userId;
  String? name;
  String? email;
  String? phoneNumber;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  UserInfo({
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
  });
}