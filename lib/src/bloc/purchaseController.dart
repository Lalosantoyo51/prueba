import '../resource/purchase.service.dart';
import '../models/provision.dart';
import '../models/purchase.model.dart';


class PurchaseController {
  final PurchaseService _purchaseService = new PurchaseService();
  int numberpage;


  Future<List<Provision>> getProducts() async{
    return await _purchaseService.getProdcuts();
  }

  Future<List<PurchaseModel>> history() async{
    return await _purchaseService.history(numberpage);
  }
}