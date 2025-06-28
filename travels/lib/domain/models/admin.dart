class Admin {
  String userName;
  String password;

  Admin({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'password': password,
    };
  }
}
