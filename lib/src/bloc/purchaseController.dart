import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/models/product-place.model.dart';
import 'package:prue/src/models/sale.dart';

import '../resource/purchase.service.dart';
import '../models/provisionDetails.dart';
import '../models/purchase.model.dart';


class PurchaseController {
  final PurchaseService _purchaseService = new PurchaseService();
  final Sale sale = new Sale();
  CartModel cart = new CartModel();
  int numberpage;
  int id;
  String comment =null;


  Future<List<ProvisionDetails>> getProducts() async{
    return await _purchaseService.getProdcuts(cart.getOffice_id);
  }
  Future<List<ProductPlace>> getProductsStreet() async{
    return await _purchaseService.getProdcutsStreet(cart.getPlace_id);
  }

  Future<List<PurchaseModel>> history() async{
    return await _purchaseService.history(numberpage);
  }
  Future<List<PurchaseModel>> getOrders() async{
    return await _purchaseService.getOrders();
  }

  Future cancelOrder() async{
    return await _purchaseService.CancelOrder(id, comment);
  }
  Future<Sale> createOrder() async{
    return await _purchaseService.createSale(cart.cart);
  }

}