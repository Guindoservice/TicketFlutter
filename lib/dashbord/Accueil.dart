import 'package:flutter/material.dart';
import 'package:gestion_ticket/dashbord/Apprenant.dart';
import 'package:gestion_ticket/dashbord/Categorie.dart';
import 'package:gestion_ticket/dashbord/Utilisateur.dart';
import 'package:gestion_ticket/dashbord/Historiques.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5CA767),
        title: Row(
          children: <Widget>[
            Container(
                width: 50,
                height: 50,
                child: Image.asset(
                  "assets/images/logoTicke.png",
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white, // Couleur de la bordure
                    width: 2,
                  ),
                )),
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {}),
            Text(
              'Accueil',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Utilisateur()),
                  );
                }),
            Text(
              'Formateur',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Apprenant()),
                  );
                }),
            Text(
              'Apprenant',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.category,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Categorie()),
                  );
                }),
            Text(
              'Catégorie',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.update,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Historiques()),
                  );
                }),
            Text(
              'Historique',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
