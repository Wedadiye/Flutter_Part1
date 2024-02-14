import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controlleurs/medicamentController.dart';






class MedicamentListScreen extends StatelessWidget {

  final MedicamentController medicamentController = Get.put(MedicamentController());

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;

    // Récupérez l'ID de la pharmacie depuis les arguments de la route
    final int pharmacyId = args?['pharmacyId'] ?? 0;

    print('Récupération des médicaments pour l\'ID de pharmacie : $pharmacyId');


    // Réinitialisez la liste des résultats pour afficher tous les médicaments de la pharmacie
    medicamentController.resetResult();

    // Appelez la méthode pour récupérer les médicaments en fonction de l'ID de la pharmacie
    medicamentController.fetchMedicaments(pharmacyId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des médicaments'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                medicamentController.searchMedicaments(query);
              },
              decoration: InputDecoration(
                labelText: 'Rechercher des médicaments',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(

                itemCount: medicamentController.result.length,
                itemBuilder: (context, index) {
                  var medicament = medicamentController.result[index];
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(medicament.nom),
                      //subtitle: Text(medicament.image),
                      trailing: Text('${medicament.prix} \MRU'),
                      leading: SizedBox(
                        width: 100,// Limitez la largeur de l'image
                        height: 100,
                          child: Image.network(
                              medicament.image, // Remplacez cette URL par l'URL de l'image du médicament
                              fit: BoxFit.cover, // Ajustez la taille de l'image selon vos besoins
                            ),


                        ),
                      ),

                    );

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
