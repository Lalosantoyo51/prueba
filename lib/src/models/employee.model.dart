class EmployeeModel{
  int id;
  String name;
  String last_name;
  String phone;

  EmployeeModel({this.id,this.name,this.last_name,this.phone});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
        id: json['id'],
        name: json['name'],
        last_name: json['last_name'],
        phone: json['phone'],
    );
  }
}