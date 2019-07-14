class ProductModel {
  final int id;
  final String name;
  final String description;
  final String product_type;
  int cost;
   int quantity;
   int provision_detail_id;
   int product_place_id;
  int value = 0;
  ProductModel({this.id, this.name, this.description, this.product_type,
    this.quantity,this.value,this.provision_detail_id,this.product_place_id,this.cost});

  Map toJson() => {
    'id' : this.product_place_id,
    'quantity' : this.value,
    'provision_detail_id' : this.provision_detail_id,
  };


  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        product_type: json['product_type'],
        quantity: json['quantity'],
    );
  }

}