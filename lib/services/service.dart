import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:felimma_admin/models/service.dart';

class ServiceServices {
  String collection = "services";
  Firestore _firestore = Firestore.instance;

  Future createService({Map data})async{
    _firestore.collection(collection).document(data['id']).setData({
      "id": data['id'],
      "name": data['name'],
      "image": data['image'],
      "rates": data['rates'],
      "price": data['price'],
      "category": data['category'],
      "client": data['client'],
      "duration": data['duration'],
      "clientId": data['clientId'],
      "description": data['description'],
      "address": data['address'],
      "phoneNumber": data['phoneNumber'],
      "featured": data['featured'],
      "onSale": data['onSale'],
    });
  }

  Future<List<ServiceModel>> getServices() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ServiceModel> services = [];
        for (DocumentSnapshot service in result.documents) {
          services.add(ServiceModel.fromSnapshot(service));
        }
        return services;
      });


  //Delete Service
  Future deleteService(String id) async {
    _firestore.collection(collection).document(id).delete();
  }

  //edit service
  Future updateService({Map data})async{
    _firestore.collection(collection).document(data['id']).setData({
      "id": data['id'],
      "name": data['name'],
      "image": data['image'],
      "price": data['price'],
      "category": data['category'],
      "client": data['client'],
      "duration": data['duration'],
      "clientId": data['clientId'],
      "description": data['description'],
      "address": data['address'],
      "phoneNumber": data['phoneNumber'],
      "featured": data['featured'],
      "onSale": data['onSale'],
    });
  }


  Future<List<ServiceModel>> getServiceByClient({String id}) async =>
      _firestore
          .collection(collection)
          .where("clientId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<ServiceModel> services = [];
        for (DocumentSnapshot service in result.documents) {
          services.add(ServiceModel.fromSnapshot(service));
        }
        print("SERVICES: ${services.length}");
        print("SERVICES: ${services.length}");
        print("SERVICES: ${services.length}");
        print("SERVICES: ${services.length}");
        print("SERVICES: ${services.length}");

        return services;
      });

  Future<List<ServiceModel>> getServicesOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<ServiceModel> services = [];
        for (DocumentSnapshot service in result.documents) {
          services.add(ServiceModel.fromSnapshot(service));
        }
        return services;
      });

  Future<List<ServiceModel>> searchServices({String serviceName}) {
    // code to convert the first character to uppercase
    String searchKey = serviceName[0].toUpperCase() + serviceName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<ServiceModel> services = [];
      for (DocumentSnapshot service in result.documents) {
        services.add(ServiceModel.fromSnapshot(service));
      }
      return services;
    });
  }

}
