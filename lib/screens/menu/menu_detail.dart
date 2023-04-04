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
import '../inventory/add_inventory_for_menu.dart';
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
  late TextEditingController _imageController;
  late TextEditingController _priceController;
  late DateTime _createdDate;
  late bool _isSpecial;
  late String _errorMessage;
  final ImagePicker _picker = ImagePicker();
  File? image;

  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _dishNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageController = TextEditingController();
    _priceController = TextEditingController();
    _isSpecial = false;
    _createdDate = DateTime.now();
    if (widget.id != 0) {
      fetchMenuItem(widget.id);
    }
  }

  formSubmitted(dishName, dishDescription, dishPrice, isSpecial) {
    final data = <String, String>{
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
          headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _dishNameController.text = data['name'];
          _descriptionController.text = data['description'];
          image = data['image'];
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

  Future<void> createMenuItem(Map<String, String> data) async {
    try {
      final String accessToken = LocalStorage('tokens').getItem('access');
      final Uri url =
          Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.MENUS}');
      final http.MultipartRequest request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $accessToken'
        ..fields.addAll(data);

      final http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath(
        'image',
        image!.path.toString(),
      );
      request.files.add(multipartFile);

      final http.StreamedResponse response = await request.send();
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
      print(error);
    }
  }

  Future<void> updateMenuItem(int id, data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.MENUS}$id/');
      final response = await http.put(
        url,
        headers: {"Authorization": "Bearer " + access_token},
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
          .delete(url, headers: {"Authorization": "Bearer " + access_token});
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddInventoryForMenu(menuId: widget.id),
            ),
          );
        },
        label: const Text(
          'Add Inventory',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: const Text(
          "Add Menu",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuList()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Menu > ${_dishNameController.text == '' ? 'Add New Menu' : _dishNameController.text}",
                style: const TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Merriweather"),
              ),
              IconButton(
                  onPressed: () {
                    _dishNameController.text == '' ? null : deleteMenuItem();
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: _dishNameController.text == ''
                        ? Colors.grey
                        : Colors.red,
                    size: 35.0,
                  ))
            ],
          ),
          const Divider(
            color: Color.fromARGB(221, 124, 124, 124),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 243, 243),
              boxShadow: List.filled(
                3,
                const BoxShadow(
                  blurRadius: 4,
                  blurStyle: BlurStyle.outer,
                  color: Color.fromARGB(31, 176, 176, 176),
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
                                // width: 190,
                                child: TextFormField(
                                  controller: _dishNameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      hintText:
                                          '${_dishNameController.text == "" ? "Dish name" : _dishNameController.text}',
                                      border: OutlineInputBorder()),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                      color: Colors.white,
                                      // width: 190,
                                      child: TextFormField(
                                        controller: _dishNameController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            hintText:
                                                '${_dishNameController.text == "" ? "Dish Catagory" : _dishNameController.text}',
                                            border: OutlineInputBorder()),
                                      )),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: image == null
                                          ? AssetImage(
                                                  'assets/images/gallery.png')
                                              as ImageProvider
                                          : FileImage(File(image!.path)),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              // width: 190,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                        color: Colors.white,
                                        // width: 90,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _priceController,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              hintText:
                                                  '${_priceController.text == "" ? "\$0.0" : _priceController.text}',
                                              border: OutlineInputBorder()),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text('Special'),
                                        Checkbox(
                                            value: _isSpecial,
                                            onChanged: ((value) => setState(() {
                                                  _isSpecial = value!;
                                                })))
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
