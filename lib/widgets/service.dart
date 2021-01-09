import 'package:flutter/material.dart';
import 'package:felimma_admin/services/style.dart';
import 'package:felimma_admin/models/service.dart';
import 'package:felimma_admin/screens/edit_service.dart';
import 'package:felimma_admin/providers/user.dart';
import 'package:felimma_admin/services/service.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class ServiceWidget extends StatelessWidget {
  final ServiceModel service;

  const ServiceWidget({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Provider = Provider.of<ClientProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ]),
//            height: 160,
        child: Row(
          children: <Widget>[
            Container(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(
                  service.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: service.name,
                          weight: FontWeight.w500,
                          size: 18,
                        ),
                      ),
                      Divider(),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return List<PopupMenuEntry<String>>()
                            ..add(PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ))
                            ..add(PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ));
                        },
                        onSelected: (String value) async {
                          print(value);
                          if (value == 'edit') {
                            // TODO: edit service
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Are You Sure ?'),
                                  content: Text(
                                      'Do you want to edit ${service.name} from your account?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditServiceScreen()),
                                          );
                                          await userProvider.reload();
                                        }),
                                  ],
                                );
                              },
                            );
                          } else if (value == 'delete') {
                            // TODO: delete service
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Are You Sure ?'),
                                  content: Text(
                                      'Do you want to delete ${service.name} from your account?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onPressed: () async {
                                        await ServiceServices()
                                            .deleteService(service.id);
                                        Navigator.pop(context);
                                        await userProvider.reload();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: CustomText(
                              text: service.client,
                              color: Colors.black,
                              weight: FontWeight.w700,
                              size: 14,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                            text: "RP${service.price}",
                            weight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
