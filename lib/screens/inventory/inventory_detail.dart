import 'package:flutter/material.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/inventory_model.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class InventoryDetail extends StatefulWidget {
  final Inventory inventory;

  InventoryDetail({required this.inventory});

  @override
  _InventoryDetailState createState() => _InventoryDetailState();
}

class _InventoryDetailState extends State<InventoryDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int inventoryId = 0;
  late String inventoryName = "";
  late int quantity = 0;
  late String measurement = "";
  late int noticeIfBelow = 0;

  @override
  void initState() {
    super.initState();
    if (widget.inventory.inventoryId != 0) {
      inventoryId = widget.inventory.inventoryId;
      inventoryName = widget.inventory.inventoryName;
      quantity = widget.inventory.quantity;
      measurement = widget.inventory.measurement;
      noticeIfBelow = widget.inventory.noticeIfBelow;
    }
  }

  Future<void> updateInventory(data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(
          '${ApiConstants.BASE_URL}${ApiConstants.INVENTORIES}$inventoryId/');
      final response = await http.put(
        url,
        headers: {"Authorization": "JWT ${access_token}"},
        body: data,
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inventory updated successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to update inventory. Please try again!')),
        );
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to update inventory. Please try again!')),
        );
      });
      debugPrint(error.toString());
    }
  }

  Future<void> createInventory(data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url =
          Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.INVENTORIES}');
      final response = await http.post(
        url,
        headers: {"Authorization": "JWT ${access_token}"},
        body: data,
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inventory created successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to create inventory. Please try again!')),
        );
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to update inventory. Please try again!')),
        );
      });
      debugPrint(error.toString());
    }
  }

  Future<void> deleteInventory() async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(
          '${ApiConstants.BASE_URL}${ApiConstants.INVENTORIES}$inventoryId/');
      final response = await http.delete(
        url,
        headers: {"Authorization": "JWT ${access_token}"},
      );
      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inventory deleted successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to delete inventory. Please try again!')),
        );
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to delete inventory. Please try again!')),
        );
      });
      debugPrint(error.toString());
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call your method here and pass in inventoryName and quantity
      // print("${inventoryName} ${measurement} ${noticeIfBelow} ${quantity}");

      if (inventoryId != 0) {
        final data = {
          "inventory_name": inventoryName,
          "quantity": quantity.toString(),
          "measurement": measurement,
          "notice_if_below": noticeIfBelow.toString(),
          "update_remark": "Updated",
          "restaurant":
              LocalStorage('restaurant').getItem('restaurant_id').toString()
        };
        updateInventory(data);
      } else {
        final data = {
          "inventory_name": inventoryName,
          "quantity": quantity.toString(),
          "measurement": measurement,
          "notice_if_below": noticeIfBelow.toString(),
          "update_remark": "Created",
          "restaurant":
              LocalStorage('restaurant').getItem('restaurant_id').toString()
        };
        createInventory(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.inventory.inventoryId == 0 ? 'Add' : 'Edit'} Inventory"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: inventoryName,
                  decoration:
                      const InputDecoration(labelText: 'Inventory Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an inventory name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    inventoryName = value!;
                  },
                ),
                TextFormField(
                  initialValue: quantity.toString(),
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    quantity =
                        int.tryParse(value!) != null ? int.parse(value) : 0;
                  },
                ),
                TextFormField(
                  initialValue: measurement,
                  decoration: const InputDecoration(labelText: 'Measurement'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a measurement';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    measurement = value!;
                  },
                ),
                TextFormField(
                  initialValue: noticeIfBelow.toString(),
                  decoration:
                      const InputDecoration(labelText: 'Notice If Below'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a notice if below value';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a notice if below value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    noticeIfBelow =
                        int.tryParse(value!) != null ? int.parse(value) : 0;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        inventoryId == 0 ? 'Add' : 'Edit',
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Merriweather"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: inventoryId == 0
                          ? null
                          : () {
                              deleteInventory();
                            },
                      style: ButtonStyle(
                        backgroundColor: inventoryId != 0
                            ? MaterialStateProperty.all(Colors.red)
                            : MaterialStateProperty.all(Colors.grey[400]),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Merriweather",
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
