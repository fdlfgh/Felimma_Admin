import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const ADDRESS = "address";
  static const PHONENUMBER = "phoneNumber";
  static const POSTALCODE = "postalCode";
  static const CITY = "city";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String _name;
  String _address;
  String _phoneNumber;
  String _postalCode;
  String _city;
  String _email;
  String _id;
  String _stripeId;
  int _priceSum = 0;

//  getters
  String get name => _name;

  String get address => _address;

  String get phoneNumber => _phoneNumber;

  String get postalCode => _postalCode;

  String get city => _city;

  String get email => _email;

  String get id => _id;

  String get stripeId => _stripeId;

  // public variables
  List<CartItemModel> cart;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _address = snapshot.data[ADDRESS];
    _phoneNumber = snapshot.data[PHONENUMBER];
    _postalCode = snapshot.data[POSTALCODE];
    _city = snapshot.data[CITY];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _stripeId = snapshot.data[STRIPE_ID] ?? "";
    cart = _convertCartItems(snapshot.data[CART] ?? []);
    totalCartPrice = snapshot.data[CART] == null
        ? 0
        : getTotalPrice(cart: snapshot.data[CART]);
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"];
    }

    int total = _priceSum;
    return total;
  }
}
