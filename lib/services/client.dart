
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client.dart';

class ClientServices {
  String collection = "client";
  Firestore _firestore = Firestore.instance;

  Future<List<ClientModel>> getClients() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ClientModel> clients = [];
        for(DocumentSnapshot client in result.documents){
          clients.add(ClientModel.fromSnapshot(client));
        }
        return clients;
      });

  Future<ClientModel> getClientById({String id}) => _firestore.collection(collection).document(id.toString()).get().then((doc){
    return ClientModel.fromSnapshot(doc);
  });

  Future<List<ClientModel>> searchClient({String clientName}) {
    // code to convert the first character to uppercase
    String searchKey = clientName[0].toUpperCase() + clientName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<ClientModel> clients = [];
      for (DocumentSnapshot service in result.documents) {
        clients.add(ClientModel.fromSnapshot(service));
      }
      return clients;
    });
  }
}