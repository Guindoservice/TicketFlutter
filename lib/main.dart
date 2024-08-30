import 'package:flutter/material.dart';
import 'package:gestion_ticket/pages/Apprenantform.dart';
import 'package:gestion_ticket/pages/ChatPage.dart';
import 'package:gestion_ticket/pages/FormateurForm.dart';
import 'package:gestion_ticket/pages/Historique.dart';
import 'package:gestion_ticket/pages/Homepage.dart';
import 'package:gestion_ticket/pages/Principale.dart';
import 'package:gestion_ticket/pages/User.dart';
import 'package:gestion_ticket/ticket/DetailTicket.dart';
import 'package:gestion_ticket/ticket/ListeNoRepondu.dart';
import 'package:gestion_ticket/ticket/ReponseTicket.dart';
import 'package:gestion_ticket/users/LoginPage.dart';

import 'categorie/CatPedagogique.dart';
import 'categorie/CatPratique.dart';
import 'categorie/CatTechnique.dart';
import 'categorie/CatTheorique.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/Homepage": (context) => Homepage(),
        "/LoginPage": (context) => LoginPage(),
        "/Principale": (context) => Principale(),
        "/Historique": (context) => Historique(),
        "/ChatPage": (context) => Chatpage(),
        "/User": (context) => User(),
        "/Apprenantform": (context) => Apprenantform(),
        "/CateTechnique": (context) => CateTechnique(),
        "/CatPratique": (context) => CatPratique(),
        "/Catpedagogique": (context) => Catpedagogique(),
        "/Cattheorique": (context) => Cattheorique(),
        "/Detailticket": (context) => Detailticket(),
        "/Formateurform": (context) => Formateurform(),
        "/Reponseticket": (context) => Reponseticket(),
        "/Listenorepondu": (context) => Listenorepondu(),
      },
      title: "Accueil",
      home: Historique(),
      theme: ThemeData(
          indicatorColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            primary: Color(0xFF312070),
            secondary: Color(0xFF5CA767),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
