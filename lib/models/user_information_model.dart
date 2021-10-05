class UserInformation {
  final String identifyCard;
  final String fullName;
  final String email;
  final String phoneNumber;

  UserInformation({required this.identifyCard, required this.fullName, required this.email, required this.phoneNumber});

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      identifyCard: json['identifyCard'].toString(),
      fullName: json['fullName'].toString(),
      email: json['email'].toString(),
      phoneNumber: json['phoneNumber'].toString(),
    );
  }
}

