import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const DURATION = "duration";
  static const CLIENT_ID = "clientId";
  static const CLIENT = "client";
  static const DESCRIPTION = "description";
  static const PHONENUMBER = "phoneNumber";
  static const ADDRESS = "address";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const ONSALE = "onSale";

  String _id;
  String _name;
  String _clientId;
  String _address;
  bool _onSale;
  String _phoneNumber;
  String _client;
  String _duration;
  String _category;
  String _image;
  String _description;

  int _price;

  bool _featured;

  String get id => _id;

  String get name => _name;

  String get address => _address;

  String get duration => _duration;

  String get phoneNumber => _phoneNumber;

  bool get onSale => _onSale;

  String get client => _client;

  String get clientId => _clientId;

  String get category => _category;

  String get description => _description;

  String get image => _image;

  int get price => _price;

  bool get featured => _featured;

  // public variable

  ServiceModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
    _client = snapshot.data[CLIENT];
    _onSale = snapshot.data[ONSALE];
    _address = snapshot.data[ADDRESS];
    _phoneNumber = snapshot.data[PHONENUMBER];
    _duration = snapshot.data[DURATION];
    _clientId = snapshot.data[CLIENT_ID];
    _description = snapshot.data[DESCRIPTION];
    _id = snapshot.data[ID];
    _featured = snapshot.data[FEATURED];
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _name = snapshot.data[NAME];
  }
}
