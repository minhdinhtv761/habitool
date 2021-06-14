class UserModel {
  String uid;
  String avatarUrl;
  String email;
  String password;

  UserModel(this.uid, {this.avatarUrl});

  UserModel.formJson(Map<String, dynamic> data) {
    uid = data["uid"];
    email = data["email"];
  }
}
