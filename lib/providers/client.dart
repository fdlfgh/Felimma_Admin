import 'package:flutter/material.dart';
import '../services/client.dart';
import '../models/client.dart';

class ClientProvider with ChangeNotifier{
  ClientServices _clientServices = ClientServices();
  List<ClientModel> clients = [];
  List<ClientModel> searchedClients = [];

  ClientModel client;

  ClientProvider.initialize(){
    loadClients();
  }

  loadClients()async{
    clients = await _clientServices.getClients();
    notifyListeners();
  }

  loadSingleClient({String clientId}) async{
    client = await _clientServices.getClientById(id: clientId);
    notifyListeners();
  }

  Future search({String name})async{
    searchedClients = await _clientServices.searchClient(clientName: name);
    print("CLIE ARE: ${searchedClients.length}");
    notifyListeners();
  }
}