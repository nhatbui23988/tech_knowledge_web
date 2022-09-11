import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:flutter/material.dart';

class HomePageController extends BaseController {
  HomePageController() {
    getData();
  }

  void getData() async {
     final document =
        await FirebaseFirestore.instance.collection('Concept').get();
     final docsLength = document.docs.length;
     print('document.docs.length $docsLength');
     if(docsLength > 0){
       for (var element in document.docs) {
         element.data().keys.forEach((keyData) { 
           print('keyData $keyData : ${element.get(keyData)}');
         });
       }
     }
  }
}
