import 'dart:io';

import 'package:flutter/material.dart';
import 'package:felimma_admin/models/service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../services/service.dart';

class ServiceProvider with ChangeNotifier{
  ServiceServices _serviceServices = ServiceServices();
  List<ServiceModel> services = [];
  List<ServiceModel> servicesByCategory = [];
  List<ServiceModel> servicesSearched = [];
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  bool featured = false;
  bool onSale = false;
  File serviceImage;
  final picker = ImagePicker();
  String serviceImageFileName;




  ServiceProvider.initialize(){
    loadServices();
  }

  loadServices()async{
    services = await _serviceServices.getServices();
    notifyListeners();
  }

  Future loadServiceByCategory({String categoryName})async{
    servicesByCategory = await _serviceServices.getServicesOfCategory(category: categoryName);
    notifyListeners();
  }



  Future<bool> uploadService({String category, String client, String clientId})async{
    try{
      String id = Uuid().v1();
      String imageUrl = await _uploadImageFile(imageFile: serviceImage, imageFileName: id);
      Map data = {
        "id": id,
        "name": name.text.trim(),
        "image": imageUrl,
        "rating": 0.0,
        "price": int.parse(price.text.trim()),
        "client": client,
        "clientId": clientId,
        "description": description.text.trim(),
        "category": category,
        "address": address.text.trim(),
        "phoneNumber": phoneNumber.text.trim(),
        "duration": duration.text.trim(),
        "featured": featured,
        "onSale": onSale,
      };
      _serviceServices.createService(data:data);
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<bool> editService({String category, String client, String clientId})async{
    try{
      String id = Uuid().v1();
      String imageUrl = await _uploadImageFile(imageFile: serviceImage, imageFileName: id);
      Map data = {
        "id": id,
        "name": name.text.trim(),
        "image": imageUrl,
        "rating": 0.0,
        "price": int.parse(price.text.trim()),
        "client": client,
        "clientId": clientId,
        "description": description.text.trim(),
        "category": category,
        "address": address.text.trim(),
        "phoneNumber": phoneNumber.text.trim(),
        "duration": duration.text.trim(),
        "featured": featured,
        "onSale": onSale,
      };
      _serviceServices.updateService(data:data);
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  changeFeatured(){
    featured = !featured;
    notifyListeners();
  }

  changeOnSale(){
    onSale = !onSale;
    notifyListeners();
  }

//  method to load image files
  getImageFile({ImageSource source})async{
    final pickedFile = await picker.getImage(source: source, maxWidth: 640, maxHeight: 400);
    serviceImage = File(pickedFile.path);
    serviceImageFileName = serviceImage.path.substring(serviceImage.path.indexOf('/' ) + 1);
    notifyListeners();
  }

//  method to upload the file to firebase
  Future _uploadImageFile({File imageFile, String imageFileName})async{
    StorageReference reference = FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return imageUrl;
  }

  Future search({String serviceName})async{
    servicesSearched = await _serviceServices.searchServices(serviceName: serviceName);
    print("THE NUMBER OF SERVICES DETECTED IS: ${servicesSearched.length}");
    print("THE NUMBER OF SERVICES DETECTED IS: ${servicesSearched.length}");
    print("THE NUMBER OF SERVICES DETECTED IS: ${servicesSearched.length}");

    notifyListeners();
  }

  clear(){
    serviceImage = null;
    serviceImageFileName = null;
    name = null;
    address = null;
    phoneNumber = null;
    description = null;
    price = null;
    duration = null;
  }
}