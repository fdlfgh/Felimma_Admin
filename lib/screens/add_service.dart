import 'package:flutter/material.dart';
import 'package:felimma_admin/services/style.dart';
import 'package:felimma_admin/providers/app_states.dart';
import 'package:felimma_admin/providers/category.dart';
import 'package:felimma_admin/providers/service.dart';
import 'package:felimma_admin/providers/user.dart';
import 'package:felimma_admin/widgets/custom_file_button.dart';
import 'package:felimma_admin/widgets/custom_text.dart';
import 'package:felimma_admin/widgets/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    print(categoryProvider.categoriesNames);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: CustomText(text: "Add Service"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: appProvider.isLoading
          ? Loading()
          : ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: serviceProvider?.serviceImage == null
                            ? CustomFileUploadButton(
                                icon: Icons.image,
                                text: "Add image",
                                onTap: () async {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return Container(
                                          child: new Wrap(
                                            children: <Widget>[
                                              new ListTile(
                                                  leading:
                                                      new Icon(Icons.image),
                                                  title:
                                                      new Text('From gallery'),
                                                  onTap: () async {
                                                    serviceProvider
                                                        .getImageFile(
                                                            source: ImageSource
                                                                .gallery);
                                                    Navigator.pop(context);
                                                  }),
                                              new ListTile(
                                                  leading: new Icon(
                                                      Icons.camera_alt),
                                                  title:
                                                      new Text('Take a photo'),
                                                  onTap: () async {
                                                    serviceProvider
                                                        .getImageFile(
                                                            source: ImageSource
                                                                .camera);
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:
                                    Image.file(serviceProvider.serviceImage)),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: serviceProvider.serviceImage != null,
                  child: FlatButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                      leading: new Icon(Icons.image),
                                      title: new Text('From gallery'),
                                      onTap: () async {
                                        serviceProvider.getImageFile(
                                            source: ImageSource.gallery);
                                        Navigator.pop(context);
                                      }),
                                  new ListTile(
                                      leading: new Icon(Icons.camera_alt),
                                      title: new Text('Take a photo'),
                                      onTap: () async {
                                        serviceProvider.getImageFile(
                                            source: ImageSource.camera);
                                        Navigator.pop(context);
                                      }),
                                ],
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "Change Image",
                      color: primary,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomText(text: "Featured"),
                        Switch(
                            value: serviceProvider.featured,
                            onChanged: (value) {
                              serviceProvider.changeFeatured();
                            })
                      ],
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomText(text: "On Sale"),
                        Switch(
                            value: serviceProvider.onSale,
                            onChanged: (value) {
                              serviceProvider.changeOnSale();
                            })
                      ],
                    )),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomText(
                      text: "Category:",
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    DropdownButton<String>(
                      value: categoryProvider.selectedCategory,
                      style: TextStyle(
                          color: primary, fontWeight: FontWeight.bold),
                      icon: Icon(
                        Icons.filter_list,
                        color: primary,
                      ),
                      elevation: 0,
                      onChanged: (value) {
                        categoryProvider.changeSelectedCategory(
                            newCategory: value.trim());
                      },
                      items: categoryProvider.categoriesNames
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          controller: serviceProvider.name,
                          decoration: InputDecoration(
                              hintText: "Service name",
                              icon: Icon(Icons.person_outline),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The name field cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          maxLines: 5,
                          controller: serviceProvider.description,
                          decoration: InputDecoration(
                              hintText: "Service description",
                              icon: Icon(Icons.work),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The name field cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          maxLines: 5,
                          controller: serviceProvider.address,
                          decoration: InputDecoration(
                              hintText: "Please enter your address",
                              icon: Icon(Icons.home),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The name field cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          controller: serviceProvider.phoneNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Phone number",
                              icon: Icon(Icons.phone),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The name field cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          controller: serviceProvider.duration,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Duration",
                              icon: Icon(Icons.timer),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The name field cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          controller: serviceProvider.price,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Price",
                              icon: Icon(Icons.monetization_on),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The name field cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.3),
                              offset: Offset(2, 7),
                              blurRadius: 4)
                        ]),
                    child: FlatButton(
                      onPressed: () async {
                        appProvider.changeLoading();
                        if (!await serviceProvider.uploadService(
                            category: categoryProvider.selectedCategory,
                            clientId: userProvider.client.id,
                            client: userProvider.client.name)) {
                          _key.currentState.showSnackBar(SnackBar(
                            content: Text("Upload Failed"),
                            duration: const Duration(seconds: 10),
                          ));
                          appProvider.changeLoading();
                          return;
                        }
                        serviceProvider.clear();
                        _key.currentState.showSnackBar(SnackBar(
                          content: Text("Upload completed"),
                          duration: const Duration(seconds: 10),
                        ));
                        userProvider.loadServicesByClient(
                            clientId: userProvider.client.id);
                        await userProvider.reload();
                        appProvider.changeLoading();
                        Navigator.pop(context);
                      },
                      child: CustomText(
                        text: "Post",
                        color: white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
