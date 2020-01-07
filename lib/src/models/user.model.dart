
class UserModel  {
  int id;

  String name;

  String last_name;

  String gender;

  String phone;

  String birthday;

  String password;

  String newpassword;

  String newpassword_confirmation;
  int verified;

  UserModel({this.id, this.name, this.last_name, this.gender, this.phone,
      this.birthday, this.password,this.newpassword,
    this.newpassword_confirmation, this.verified});

  Map toJson() => {
    'password': this.password,
    'newpassword': this.newpassword,
    'newpassword_confirmation': this.newpassword_confirmation,
  };

  factory UserModel.fromJson(Map<String, dynamic> json){
    return new UserModel(
      id : json['id'],
      name : json['name'],
      last_name : json ['last_name'],
      gender : json['gender'],
      phone : json['phone'],
      birthday : json['birthday'],
      verified: json['verified']
    );
  }


}
