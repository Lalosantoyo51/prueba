class SignUpFacebookModel {
  String name;
  String last_name;
  String email;
  String phone;
  String gender;
  int facebook_id;
  String birthday;

  SignUpFacebookModel.init();

  SignUpFacebookModel({this.last_name,this.email,this.phone,this.gender,
    this.facebook_id,this.birthday});


  Map toJson()=>{
    "name": this.name,
    "last_name": this.last_name,
    "email": this.email,
    "phone": this.phone,
    "facebook_id": this.facebook_id,
    "birthday": this.birthday,
    "gender": this.gender,
  };


}