import 'package:prue/src/models/place.model.dart';
import 'package:prue/src/models/purchase_offices.dart';

import './sale-details-model.dart';
import './employee.model.dart';
import './place-user.model.dart';
import './Raiting.model.dart';
import 'offices.dart';

class PurchaseModel {
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
  OficcesPurchase offices;
  PlaceModel place;


  PurchaseModel({this.id, this.created_at, this.cost, this.employeeModel,
    this.status, this.payment_type, this.place_id, this.employee_id, this.payment,
    this.oficce_id, this.place_user, this.place_user_id, this.qualified_by_customer,
    this.qualified_by_employee, this.ratings, this.sale_details, this.offices,
    this.place});


  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    var sale_detail = json['sale_details'] as List;
    var rating = json['ratings'] as List;
    var office = json['office'];
    var placeUser = json['place_user'];
    var place = json['place'];
    List<SaleDetailsModel> _saleDetail = new List();
    List<RaitinsMoldel> _rating = new List();
    OficcesPurchase _offices = new OficcesPurchase();
    PlaceUserModel _placeUser = new PlaceUserModel();
    PlaceModel _place = new PlaceModel();

    if (sale_detail != null) _saleDetail =
        sale_detail.map((i) => SaleDetailsModel.fromJson(i)).toList();
    if (rating != null)
      _rating = rating.map((i) => RaitinsMoldel.fromJson(i)).toList();
    if (office != null) _offices = OficcesPurchase.fromJson(office);
    if (placeUser != null) _placeUser = PlaceUserModel.fromJson(placeUser);
    if (place != null) _place = PlaceModel.fromJson(place);


    return PurchaseModel(
        id: json['id'],
        employee_id: json['employee_id'],
        place_id: json['place_id'],
        oficce_id: json['office_id'],
        place_user_id: json['place_user_id'],
        cost: json['cost'],
        payment_type: json['payment_type'],
        qualified_by_customer: json['qualified_by_customer'],
        qualified_by_employee: json['qualified_by_employee'],
        created_at: json['created_at'],
        status: json['status'],
        payment: json['payment'],
        sale_details: _saleDetail,
        employeeModel: new EmployeeModel.fromJson(json['employee']),
        place_user: _placeUser,
        offices: _offices,
        place: _place
    );
  }

  factory PurchaseModel.fromJsonPage(Map<String, dynamic> json) {
    return PurchaseModel();
  }
}