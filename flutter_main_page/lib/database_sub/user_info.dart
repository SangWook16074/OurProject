// ignore_for_file: unused_local_variable

class UserInfo {
  String? userNumber;
  String? userName;
  String? password;
  int? userGrade;
  String? userClassify;
  bool isAdmin;

  UserInfo(this.userNumber, this.userName, this.userGrade, this.userClassify,
      {this.password, this.isAdmin = false});

  name() {
    return this.userName;
  }

  number() {
    return this.userNumber;
  }

  grade() {
    return this.userGrade;
  }

  classify() {
    return this.userClassify;
  }
}
