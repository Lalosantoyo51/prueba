
class UserModel  {
  int id;

  String name;

  String last_name;

  String gender;

  String phone;

  String birthday;

  UserModel({this.id, this.name, this.last_name, this.gender, this.phone,
      this.birthday});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return new UserModel(
      id : json['id'],
      name : json['name'],
      last_name : json ['last_name'],
      gender : json['gender'],
      phone : json['phone'],
      birthday : json['birthday']
    );
  }


}