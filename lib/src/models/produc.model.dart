class ProductModel {
  final int id;
  final String name;
  final String description;
  final String product_type;

  ProductModel({this.id, this.name, this.description, this.product_type});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        product_type: json['product_type'],
    );
  }

}