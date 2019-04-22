import 'package:prue/src/models/message.model.dart';

class MessageResponse {
  final messageModel results;
  final String error;
  MessageResponse(this.results,this.error);


  MessageResponse.fromJson(Map<String, dynamic> json)
      : results = new messageModel.fromJson(json),
        error = "";

}