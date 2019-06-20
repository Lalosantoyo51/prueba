import './sale-details-model.dart';
import './employee.model.dart';
import './building.model.dart';
import './place-user.model.dart';
import './Raiting.model.dart';

class pruchaseModel {
  int id;
  int employee_id;
  int place_id;
  int oficce_id;
  int place_user_id;
  int cost;
  String payment_type;
  String qualified_by_customer;
  String qualified_by_employee;
  String created_at;
  String status;
  String payment;
  List<SaleDetailsModel> sale_details;
  List<RaitinsMoldel> ratings;
  EmployeeModel employeeModel;
  PlaceUserModel place_user;


}