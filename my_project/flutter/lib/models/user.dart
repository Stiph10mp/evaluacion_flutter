class User {
  final int id;
  final String user;
  final String email;

  User({
    required this.id,
    required this.user,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['User_id'] ?? 0,
      user: json['User_user'] ?? '',
      email: json['User_email'] ?? '',
    );
  }
}