import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const CATEGORY = "category";

  int _id;
  String _name;
  String _image;
  String _category;

  //  getters
  int get id => _id;

  String get name => _name;

  String get image => _image;

  String get category => _category;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
    _category = snapshot.data[CATEGORY];

  }
}
