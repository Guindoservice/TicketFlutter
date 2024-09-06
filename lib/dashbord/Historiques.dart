import 'package:flutter/material.dart';
import 'package:gestion_ticket/dashbord/Apprenant.dart';
import 'package:gestion_ticket/dashbord/Categorie.dart';
import 'package:gestion_ticket/dashbord/Utilisateur.dart';

import '../pages/Principale.dart';
import 'Accueil.dart';

class Historiques extends StatefulWidget {
  const Historiques({super.key});

  @override
  State<Historiques> createState() => _DashbordState();
}

class _DashbordState extends State<Historiques> {
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashbord()),
                );
              },
              child: Row(children: <Widget>[
                Icon(
                  Icons.home,
                  color: Color(0xFFFFFFFF),
                ),
                Text(
                  'Accueil',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ]),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Utilisateur()),
                );
              },
              child: Row(children: <Widget>[
                Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
                Text(
                  'Utiisateurs',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ]),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Utilisateur()),
                );
              },
              child: Row(children: <Widget>[
                Icon(
                  Icons.messenger_outline,
                  color: Color(0xFFFFFFFF),
                ),
                Text(
                  'Ticket',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ]),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Principale()),
                );
              },
              child: Row(children: <Widget>[
                Icon(
                  Icons.category,
                  color: Color(0xFFFFFFFF),
                ),
                Text(
                  'Catégorie',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ]),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(children: <Widget>[
                Icon(
                  Icons.update,
                  color: Color(0xFFFFFFFF),
                ),
                Text(
                  'Historique',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ]),
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
