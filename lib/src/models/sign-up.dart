import './sign-in.dart';
class SignUpModel extends SignInModel{
  String name;
  String last_name;
  String email;
  num phone;
  String  password;
  String password_confirmation;
  String birthday;
  String gender;

  SignUpModel.fromjson(Map json){
    this.name = json['name'];
    this.last_name = json['last_name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.name = json['name'];
    this.birthday = json['birthday'];
    this.gender = json['gender'];
  }

}