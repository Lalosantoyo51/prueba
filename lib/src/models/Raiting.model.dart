class RaitinsMoldel {
  int id;
  int sale_id;
  int qualification;
  String type;


  RaitinsMoldel({this.sale_id,this.id,this.type,this.qualification});

  factory RaitinsMoldel.fromJson(Map<String, dynamic> json) {
    return RaitinsMoldel(
        id: json['id'],
        sale_id: json['sale_id'],
        qualification: json['qualification'],
        type: json['type'],
    );
  }

}