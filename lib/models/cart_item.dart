class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const SERVICE_ID = "serviceId";
  static const PRICE = "price";
  static const DURATION = "duration";

  String _id;
  String _name;
  String _image;
  String _serviceId;
  String _duration;
  int _price;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get serviceId => _serviceId;

  String get duration => _duration;

  int get price => _price;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _serviceId = data[SERVICE_ID];
    _price = data[PRICE];
    _duration = data[DURATION];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        SERVICE_ID: _serviceId,
        PRICE: _price,
        DURATION: _duration,
      };
}
