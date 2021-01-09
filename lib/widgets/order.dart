import 'package:flutter/material.dart';
import 'package:felimma_admin/services/style.dart';
import 'package:felimma_admin/models/order.dart';
import 'custom_text.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;

  const OrderWidget({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final clientProvider = Provider.of<ClientProvider>(context);
//    final serviceProvider = Provider.of<ServiceProvider>(context);

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
                          text: order.description,
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
                          if (value == 'edit') {
                            /*FloatingActionButton(onPressed: (){
                              changeScreen(context, EditServiceScreen());
                            },*/

                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Are You Sure'),
                                  content: Text(
                                      'Do you want to delete ${order.description}?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Delete'),
                                      onPressed: () async {
                                        /*service.id.delete();
                                        Navigator.pop(context);
                                        setState(() {});*/
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
                              text: order.status,
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
                            text: "RP${order.total}",
                            weight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
