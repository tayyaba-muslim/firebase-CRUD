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
var products= FirebaseFirestore.instance.collection("products").snapshots();
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
  stream: products,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
       child: ListTile(
         contentPadding: EdgeInsets.all(15),
         title: Text(snapshot.data!.docs[index]["title"]),
         subtitle:Text(snapshot.data!.docs[index]["desc"]), 
         trailing:Text(snapshot.data!.docs[index]["price"].toString()),
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
