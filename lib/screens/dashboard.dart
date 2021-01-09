import 'package:flutter/material.dart';
import 'package:felimma_admin/services/screen_navigation.dart';
import 'package:felimma_admin/services/style.dart';
import 'package:felimma_admin/providers/service.dart';
import 'package:felimma_admin/providers/user.dart';
import 'package:felimma_admin/screens/login.dart';
import 'package:felimma_admin/screens/orders.dart';
import 'package:felimma_admin/screens/services.dart';
import 'package:felimma_admin/widgets/custom_text.dart';
import 'package:felimma_admin/widgets/service.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'add_service.dart';

class DashboardScreen extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0.0,
        backgroundColor: white,
        actions: <Widget>[],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: white),
              accountName: CustomText(
                text: userProvider.client?.name ?? "",
                color: black,
                weight: FontWeight.bold,
                size: 25,
              ),
              accountEmail: CustomText(
                text: userProvider.user.email ?? "",
                color: black,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(
                text: "Home",
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, OrderScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(
                text: "My orders",
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, ServiceScreen());
              },
              leading: Icon(Icons.business_center),
              title: CustomText(
                text: "My Services",
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                userProvider.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: CustomText(
                text: "Log out",
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //           Custom App bar
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Text(
                      'Welcome to Felimma for client',
                      style: TextStyle(
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: Colors.grey,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                          fontSize: 60,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-2, -1),
                          blurRadius: 5),
                    ]),
                child: ListTile(
                    onTap: () {
                      changeScreen(context, OrderScreen());
                    },
                    title: CustomText(
                      text: "Orders",
                      size: 24,
                    ),
                    trailing: CustomText(
                      text: userProvider.orders.length.toString(),
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-2, -1),
                          blurRadius: 5),
                    ]),
                child: ListTile(
                    onTap: () {
                      changeScreen(context, ServiceScreen());
                    },
                    title: CustomText(
                      text: "services",
                      size: 24,
                    ),
                    trailing: CustomText(
                      text: userProvider.services.length.toString(),
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ),
            ),
          ),

          // services
          Column(
            children: userProvider.services
                .map((item) => GestureDetector(
                      onTap: () {
//                    changeScreen(context, Details(services: item,));
                      },
                      child: ServiceWidget(
                        service: item,
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 75),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          changeScreen(context, AddServiceScreen());
        },
        label: Text(
          'Add Service',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget imageWidget({bool hasImage, String url}) {
    if (hasImage)
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: 160,
        fit: BoxFit.fill,
        width: double.infinity,
      );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                size: 40,
              ),
            ],
          ),
          CustomText(text: "No Photo")
        ],
      ),
      height: 160,
    );
  }
}
