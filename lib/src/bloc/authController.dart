import 'package:flutter/material.dart';
import 'package:prue/src/models/sign-in.dart';
import 'package:prue/src/models/user.model.dart';
import '../resource/auth.service.dart';

class AuthCOntroller {


  final TextEditingController username = new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController last_name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController phone = new TextEditingController();
  final TextEditingController password_confirmation = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController gender = new TextEditingController();
  final TextEditingController newpassword_confirmation = new TextEditingController();
  final TextEditingController newpassword = new TextEditingController();
  SignInModel signInModel = new SignInModel();
  String birthday;
  int code;
  String fb_token;
  int facebook_id;

  final AuthService _authService = new AuthService();

  Future <SignInModel> signIn() async{
    return await _authService.login(signInModel);
 }

  Future signUp() async{
   return await _authService.signUp(name.text, last_name.text, email.text, phone.text, password.text, password_confirmation.text, birthday, gender.text);
 }

  Future reset() async{
    return await _authService.reset(email.text);
 }

 Future<UserModel> getUser() async {
    return await _authService.getUser();
 }

 Future signOut() async {
    return await _authService.signOut();
 }

 Future changePassword() async{
    return await _authService.changePassword(password.text, newpassword.text, newpassword_confirmation.text);
 }
 Future verifyCode() async{
    return await _authService.verifycode(1234).catchError((err){
      print(err);
    });
 }
 Future resendCode() async{
    return await _authService.resendCode();
 }
 Future signInWithFacebook() async{
    return await _authService.signInWithFacebook(fb_token,facebook_id).then((_){
      print(_);
    }).catchError((error){
      print(error);
    });
 }
 Future signUpFacebook()async{
    print(name.text);
    print(last_name.text);
    print(email.text);
    print(phone.text);
    print(facebook_id);
    print(birthday);
    print(gender.text);
    return await _authService.signUpFacebook(name.text, last_name.text, email.text, phone.text, facebook_id, birthday, gender.text);
 }
}