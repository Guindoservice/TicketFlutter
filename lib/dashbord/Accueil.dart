import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_ticket/dashbord/Apprenant.dart';
import 'package:gestion_ticket/dashbord/Categorie.dart';
import 'package:gestion_ticket/dashbord/Utilisateur.dart';
import 'package:gestion_ticket/dashbord/Historiques.dart';
import 'package:gestion_ticket/pages/Homepage.dart';
import 'package:gestion_ticket/pages/Principale.dart';

import '../users/LoginPage.dart';

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
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Retour à l'accueil au lieu d'une boucle infinie
                  Navigator.pop(context);
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
              SizedBox(width: 10),
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
                    'Utilisateurs',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ]),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Apprenant()),
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
              SizedBox(width: 10),
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
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Historiques()),
                  );
                },
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
              SizedBox(width: 10),
              // IconButton de déconnexion
              IconButton(
                icon: Icon(Icons.logout, color: Color(0xFFFFFFFF)),
                onPressed: () {
                  _deconnection();
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Contenu principal du tableau de bord',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _deconnection() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
