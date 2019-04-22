import '../resource/purchase.service.dart';
import '../models/provision.dart';
class PurchaseController {
  final PurchaseService _purchaseService = new PurchaseService();


  Future<List<Provision>> getProducts() async{
    return await _purchaseService.getProdcuts();
  }
}