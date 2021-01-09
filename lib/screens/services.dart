import 'package:flutter/material.dart';
import 'package:felimma_admin/services/style.dart';
import 'package:felimma_admin/providers/user.dart';
import 'package:felimma_admin/widgets/custom_text.dart';
import 'package:felimma_admin/widgets/service.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "services"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: Column(
        children: userProvider.services
            .map((item) => GestureDetector(
                  onTap: () {},
                  child: ServiceWidget(
                    service: item,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
