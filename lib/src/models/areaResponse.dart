import './area.model.dart';

class AreaResponse {
  final AreaModel results;
  final String error;
  AreaResponse(this.results,this.error);


  AreaResponse.fromJson(Map<String, dynamic> json)
      : results = new AreaModel.fromJson(json),
        error = "";

}