import 'package:flutter/material.dart';
import 'package:gestion_ticket/dashbord/Apprenant.dart';
import 'package:gestion_ticket/dashbord/Utilisateur.dart';
import 'package:gestion_ticket/dashbord/Historiques.dart';

import '../pages/Principale.dart';
import 'Accueil.dart';

class Categorie extends StatefulWidget {
  const Categorie({super.key});

  @override
  State<Categorie> createState() => _DashbordState();
}

class _DashbordState extends State<Categorie> {
  // recherche par date
  TextEditingController _dateController = TextEditingController();
  final TextEditingController _recherche = TextEditingController();

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
                onTap: () {},
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
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                    child: Text(
                      "TECHNIQUE",
                      style: TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5AC767),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          // Coins arrondis
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    }),
              ),
              SizedBox(
                width: 2,
              ),
              ElevatedButton(
                  child: Text(
                    "PEDAGOGIQUE",
                    style: TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF312070),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Coins arrondis
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  }),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  child: Text(
                    "PRATIQUE",
                    style: TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5AC767),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Coins arrondis
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  }),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  child: Text(
                    "THEORIQUE",
                    style: TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF312070),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Coins arrondis
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  }),
              Spacer(),
              TextField(
                controller: _recherche,
                decoration: InputDecoration(
                  hintText: "Recherche.....",
                ),
              )

              // ********************************************
            ],
          ),
        ));
  }
}
