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
      ),
      body:
      StreamBuilder(stream: products ,builder: (context,snapshot){
       if (snapshot.connectionState == ConnectionState.active){
       if (snapshot.hasData) {
         return ListView.builder(itemBuilder: (context,index){
          return Text(snapshot.data!.docs[index]["title"]);
         }, itemCount: snapshot.data!.docs.length,);
       } else {
         return Text("data nh aya");
       }
       } else{
        return Text("data not accessible");
       }
      }),
    );
  }
}
