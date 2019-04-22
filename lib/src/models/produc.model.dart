class ProductModel {
  final int id;
  final String name;
  final String description;
  final String product_type;

  ProductModel({this.id, this.name, this.description, this.product_type});

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['ndescription'],
        product_type = json['product_type'];

}