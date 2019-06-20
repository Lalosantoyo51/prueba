import 'package:flutter/material.dart';
import 'package:prue/src/models/sign-in.dart';
import 'package:prue/src/models/sign-up-facebook.dart';
import 'package:prue/src/models/sign-up.dart';
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
  SignUpModel signUpModel = new SignUpModel();
  SignUpFacebookModel signUpFacebookModel = new SignUpFacebookModel();
  String birthday;
  String code;
  String fb_token;
  int facebook_id;
  UserModel userModel = new UserModel();

  final AuthService _authService = new AuthService();

  Future <SignInModel> signIn() async{
    return await _authService.login(signInModel);
 }

  Future <SignUpModel> signUp() async{
   return await _authService.signUp(signUpModel);
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

 Future<UserModel> changePassword() async{
    userModel.password = password.text;
    userModel.newpassword = newpassword.text;
    userModel.newpassword_confirmation = newpassword_confirmation.text;
    return await _authService.changePassword(userModel);
 }
 Future verifyCode() async{
    return await _authService.verifycode(code).catchError((err){
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
    signUpFacebookModel.name = name.text;
    signUpFacebookModel.last_name = last_name.text;
    signUpFacebookModel.email = email.text;
    signUpFacebookModel.phone = phone.text;
    signUpFacebookModel.facebook_id = facebook_id;
    signUpFacebookModel.birthday = birthday;
    signUpFacebookModel.gender = gender.text;
    return await _authService.signUpFacebook(signUpFacebookModel);
 }
}