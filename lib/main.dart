import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestion_ticket/pages/Apprenantform.dart';
import 'package:gestion_ticket/pages/ChatPage.dart';
import 'package:gestion_ticket/pages/FormateurForm.dart';
import 'package:gestion_ticket/pages/Historique.dart';
import 'package:gestion_ticket/pages/Homepage.dart';
import 'package:gestion_ticket/pages/Principale.dart';
import 'package:gestion_ticket/pages/User.dart';
import 'package:gestion_ticket/ticket/DetailReponse.dart';
import 'package:gestion_ticket/ticket/DetailTicket.dart';
import 'package:gestion_ticket/ticket/ListeNoRepondu.dart';
import 'package:gestion_ticket/ticket/ReponseTicket.dart';
import 'package:gestion_ticket/users/LoginPage.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'categorie/CatPedagogique.dart';
import 'categorie/CatPratique.dart';
import 'categorie/CatTechnique.dart';
import 'categorie/CatTheorique.dart';
import 'dashbord/Accueil.dart';
import 'dashbord/Utilisateur.dart';
import 'firebase_options.dart';
// Import the generated file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        "/User": (context) => User(),
        "/Apprenantform": (context) => Apprenantform(),
        "/Formateurform": (context) => Formateurform(),
        "/Reponseticket": (context) => Reponseticket(),
        "/Dashbord": (context) => Dashbord(),
        "/Formateur": (context) => Utilisateur(),
      },
      title: "Accueil",
      home: LoginPage(),
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
