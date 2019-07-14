class Provision{
  int id;
  int user_id;
  int seller_id;
  int shift_place_id;

  Provision({this.id,this.user_id,this.seller_id,this.shift_place_id});
  factory Provision.fromJson(Map<String, dynamic> json){
    return new Provision(
        id : json['id'],
        user_id : json['user_id'],
        seller_id : json['seller_id'],
        shift_place_id : json['shift_place_id'],

    );
  }


}