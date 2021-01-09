import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:felimma_admin/services/order.dart';
import 'package:felimma_admin/services/service.dart';
import 'package:felimma_admin/services/client.dart';
import 'package:felimma_admin/models/cart_item.dart';
import 'package:felimma_admin/models/order.dart';
import 'package:felimma_admin/models/service.dart';
import 'package:felimma_admin/models/client.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  OrderServices _orderServices = OrderServices();
  ClientServices _clientServices = ClientServices();
  ServiceServices _serviceServices = ServiceServices();
  double _totalSales = 0;
  double _avgPrice = 0;

  ClientModel _client;
  List<ServiceModel> services = <ServiceModel>[];
  List<CartItemModel> cartItems = [];

//  getter
  Status get status => _status;

  FirebaseUser get user => _user;

  ClientModel get client => _client;

  double get totalSales => _totalSales;
  double get avgPrice => _avgPrice;

  // public variables
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('client').document(result.user.uid).setData({
          'name': name.text,
          'email': email.text,
          'address': address.text,
          'phoneNumber': phoneNumber.text,
          'id': result.user.uid,
          "avgPrice": 0.0,
          "image": "",
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reload() async {
    _client = await _clientServices.getClientById(id: user.uid);
    await loadServicesByClient(clientId: user.uid);
    await getOrders();
    notifyListeners();
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      await loadServicesByClient(clientId: user.uid);
      await getOrders();
      _client = await _clientServices.getClientById(id: user.uid);
    }
    notifyListeners();
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders();
    notifyListeners();
  }
  // userId: _user.uid

  Future<bool> removeFromCart({Map cartItem}) async {
    print("THE SERVI IS: ${cartItem.toString()}");

    try {
//      _userService.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future loadServicesByClient({String clientId}) async {
    services = await _serviceServices.getServiceByClient(id: clientId);
    notifyListeners();
  }
}
