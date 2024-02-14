import 'package:flutter/material.dart';
import 'Screens/pharmacies_list.dart';
import 'Screens/Medicaments.dart';
import 'package:get/get.dart';
import '../Controlleurs/PharmacyController.dart';

// ...


// ...


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final PharmacyController pharmacyController = Get.lazyPut(()=>PharmacyController());
  final PharmacyController pharmacyController = Get.put(PharmacyController());

  @override
  Widget build(BuildContext context) {
   pharmacyController.init();

    return GetMaterialApp(

        initialRoute: '/pharmacy_list',

        getPages: [

          GetPage(name: '/pharmacy_list', page: () => PharmacyListScreen()),
          GetPage(name: '/list_medicament', page: () => MedicamentListScreen()),

        ],
    );
  }
}










