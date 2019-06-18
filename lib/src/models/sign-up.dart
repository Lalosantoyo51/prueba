import './sign-in.dart';

class SignUpModel {
  String name;
  String last_name;
  String email;
  num phone;
  String password;
  String password_confirmation;
  String birthday;
  String gender;
  String access_token;

  SignUpModel(
      {this.name,
      this.last_name,
      this.email,
      this.phone,
      this.password,
      this.password_confirmation,
      this.birthday,
      this.gender,
      this.access_token,
      });

  SignUpModel.init();

  Map toJson() => {
        'name': this.name,
        'last_name': this.last_name,
        'email': this.email,
        'phone': this.phone,
        'password': this.password,
        'password_confirmation': this.password_confirmation,
        'birthday': this.birthday,
        'gender': this.gender,
      };

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      access_token: json['accessToken'],
    );
  }
}
