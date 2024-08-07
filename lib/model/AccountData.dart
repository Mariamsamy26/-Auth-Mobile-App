class AccountData {
  String? id;
  String? namee;
  String email;
  String gender;

  AccountData({
    required this.id,
    required this.namee,
    required this.email,
    required this.gender,
  });

  AccountData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          namee: json[' name'],
          email: json['email'],
          gender: json['Gender type'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Frist name": namee,
      "email": email,
      "Gender type": gender,
    };
  }
}
