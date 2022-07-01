class UserInfo {
  String userName;
  String password;
  int grade;
  String classify;
  bool isAdmin;

  UserInfo(this.userName, this.password, this.grade, this.classify,
      {this.isAdmin = false});
}
