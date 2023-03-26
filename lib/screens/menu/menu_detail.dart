import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/menu_model.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';
import 'menu_page.dart';

class MenuDetail extends StatefulWidget {
  final int id;

  const MenuDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  final _menuFormKey = GlobalKey<FormState>();
  late TextEditingController _dishNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late DateTime _createdDate;
  late bool _isSpecial;
  late String _errorMessage;

  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _dishNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _isSpecial = false;
    _createdDate = DateTime.now();
    if (widget.id != 0) {
      fetchMenuItem(widget.id);
    }
  }

  formSubmitted(dishName, dishDescription, dishPrice, isSpecial) {
    final data = <String, dynamic>{
      'name': dishName,
      'description': dishDescription,
      'price': dishPrice,
      'isSpecial': isSpecial.toString(),
      'restaurant':
          LocalStorage('restaurant').getItem('restaurant_id').toString()
    };

    if (widget.id == 0) {
      createMenuItem(data);
    } else {
      updateMenuItem(widget.id, data);
    }
  }

  Future<void> fetchMenuItem(int id) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      final response = await http.get(
          Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.MENUS}${id}/'),
          headers: {"Authorization": "JWT " + access_token});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _dishNameController.text = data['name'];
          _descriptionController.text = data['description'];
          _priceController.text = data['price'];
          _isSpecial = data['isSpecial'];
          _createdDate = DateTime.parse(data['createdOn']).toLocal();
        });
        print("=================================================");
        // print(data);
      } else {
        setState(() {
          _errorMessage = "Menu item not found.";
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = "Error fetching menu item.";
      });
    }
  }

  Future<void> createMenuItem(data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.MENUS}');
      final response = await http.post(
        url,
        headers: {"Authorization": "JWT " + access_token},
        body: data,
      );

      if (response.statusCode == 201) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _errorMessage = "Error creating menu item. please try again.";
        });
        print(_errorMessage);
      }
    } catch (error) {
      setState(() {
        _errorMessage = "Error creating menu item. please try again.";
      });
      print(_errorMessage);
    }
  }

  Future<void> updateMenuItem(int id, data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.MENUS}$id/');
      final response = await http.put(
        url,
        headers: {"Authorization": "JWT " + access_token},
        body: data,
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _errorMessage = "Error updating menu item. please try again.";
        });
        print(jsonDecode(response.body));
      }
    } catch (error) {
      setState(() {
        _errorMessage = "Error updating menu item. please try again.";
      });
      print(error);
    }
  }

  Future<void> deleteMenuItem() async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(
          '${ApiConstants.BASE_URL}${ApiConstants.MENUS}${widget.id}/');
      final response = await http
          .delete(url, headers: {"Authorization": "JWT " + access_token});
      if (response.statusCode == 204) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _errorMessage = "Error removing menu item. please try again.";
        });
        print(_errorMessage);
      }
    } catch (error) {
      setState(() {
        _errorMessage = "Error removing menu item. please try again.";
      });
      print(_errorMessage);
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false, //new line

      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          "Fast Track | Restaurant",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuList()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Menu > ${_dishNameController.text}",
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Merriweather"),
              ),
              IconButton(
                onPressed: () {
                  deleteMenuItem();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 37.0,
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.black87,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 231, 231),
              boxShadow: List.filled(
                3,
                const BoxShadow(
                  blurRadius: 4,
                  blurStyle: BlurStyle.outer,
                  color: Colors.black12,
                ),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _menuFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Color.fromARGB(255, 240, 240, 240),
                        padding: const EdgeInsets.all(2),
                        child: GestureDetector(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.cover,
                              image: image == null
                                  ? AssetImage('assets/images/gallery.png')
                                      as ImageProvider
                                  : FileImage(File(image!.path)),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // 20223-02-28 2:00 PM
                            Text(
                                '${_createdDate.year}-${_createdDate.month}-${_createdDate.day} at ${_createdDate.hour}:${_createdDate.minute} ${_createdDate.hour < 12 ? "AM" : "PM"}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                color: Colors.white,
                                width: 190,
                                child: TextFormField(
                                  controller: _dishNameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      hintText:
                                          '${_dishNameController.text == "" ? "Dish name" : _dishNameController.text}',
                                      border: OutlineInputBorder()),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    color: Colors.white,
                                    width: 80,
                                    child: TextFormField(
                                      controller: _priceController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          hintText:
                                              '${_priceController.text == "" ? "\$0.0" : _priceController.text}',
                                          border: OutlineInputBorder()),
                                    )),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text('Special'),
                                Checkbox(
                                    value: _isSpecial,
                                    onChanged: ((value) => setState(() {
                                          _isSpecial = value!;
                                        })))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    // padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _descriptionController,
                      minLines: 6,
                      maxLines: 7,
                      decoration: InputDecoration(
                          hintText: _descriptionController.text == ""
                              ? "Menu Description"
                              : _descriptionController.text,
                          border: const OutlineInputBorder()),
                    ),
                  ),
                  Text(_errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .8,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            final dishName = _dishNameController.text;
                            final dishPrice = _priceController.text;
                            final isSpecial = _isSpecial;
                            final dishDescription = _descriptionController.text;

                            formSubmitted(dishName, dishDescription, dishPrice,
                                isSpecial);
                          },
                          child: const Text('Submit')))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
