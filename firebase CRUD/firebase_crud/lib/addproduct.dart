import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  CollectionReference products = FirebaseFirestore.instance.collection('products');
  Future<void> addProduct(){
    String productTitle= _productNameController.text;
    String desc= _productDescController.text;
    int price= int.parse(_productPriceController.text);
    products.add({
      'title': productTitle,
      'desc' : desc,
      'price': price
    });
    Navigator.pop(context);
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Products"),),
      body:
      ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder()
              ),
            ),
            ),
            Padding(padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _productDescController,
              decoration: InputDecoration(
                labelText: "Product Description",
                border: OutlineInputBorder()
              ),
            ),
            ),
               Padding(padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _productPriceController,
              decoration: InputDecoration(
                labelText: "Product Price",
                border: OutlineInputBorder()
              ),
            ),
            ),
           Padding(padding: EdgeInsets.all(8.0),
           child: ElevatedButton(onPressed: addProduct, child: Text("Add Product")),
           )
        ],
      )
    );
  }
}