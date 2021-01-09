import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  static const ID = "id";
  static const NAME = "name";
  static const AVG_PRICE = "avgPrice";
  static const IMAGE = "image";

  String _id;
  String _name;
  String _image;

//  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  // public variable

  ClientModel.fromSnapshot(DocumentSnapshot snapshot) {
    // print(snapshot.data);
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
  }
}
