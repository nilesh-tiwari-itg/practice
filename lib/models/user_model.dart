class UserModel {
  String? email;
  String? fullName;
  String? profilePic;

  UserModel({this.email, this.fullName, this.profilePic});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['profilePic'] = this.profilePic;
    return data;
  }
}