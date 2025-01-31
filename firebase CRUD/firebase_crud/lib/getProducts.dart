import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class myProducts extends StatefulWidget {
   myProducts({super.key});
  @override
  State<myProducts> createState() => _myProductsState();
}

class _myProductsState extends State<myProducts> {
var products= FirebaseFirestore.instance.collection("products");

//delete
void _deleteProduct(String productId) async{
  await products.doc(productId).delete();
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text("Product deleted successfully!")),
  );
}
//edit
void _editProduct(String productId, String currentTitle, String currentDesc,  double currentPrice){
  TextEditingController titleController = TextEditingController(text: currentTitle);
  TextEditingController descController = TextEditingController(text: currentDesc);
  TextEditingController priceController = TextEditingController(text: currentPrice.toString());

  showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
      title: Text("Edit Product"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(labelText: "Description"),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: "Price"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
       TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: ()async {
         await products.doc(productId).update({
          "title": titleController.text,
          "desc": descController.text,
          "price": double.parse(priceController.text),
         });
         Navigator.pop(context);
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product Updated Sucessfully!")),
         );
          },
          child: Text('Save'),
          )
      ],
    );
    }
    );

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetching Products Firestore"),
        actions:[
          GestureDetector(child:Icon(Icons.add),
          onTap:(){
            Navigator.pushNamed(context,"/addproduct");
          })
        ]
      ),
      body:
   StreamBuilder(
  stream: products.snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemBuilder: (context, index) {
            var doc = snapshot.data!.docs[index];
            var productId = doc.id;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
              child: ListTile(
         contentPadding: EdgeInsets.all(15),
         title: Text(snapshot.data!.docs[index]["title"]),
         subtitle:Text(snapshot.data!.docs[index]["desc"]), 
         trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: (){
              _editProduct(productId, doc["title"], doc["desc"], doc["price"]);
            },
         ),
         IconButton(
          icon: Icon(Icons.delete, color:Colors.red),
          
         onPressed: (){
          _deleteProduct(productId);
         },
         )
          ]
          ),
         leading:Icon(Icons.phone)
       
    
  
),

            );
          },itemCount: snapshot.data!.docs.length,

        );
      } else {
        return Center(child: Text("Data nahi aaya"));
      }
    } else {
      return Center(child: Text("Data not accessible"));
    }
  },
)

    );
  }
}
