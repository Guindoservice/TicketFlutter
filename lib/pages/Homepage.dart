import 'dart:io';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomePage();
}

class _HomePage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5CA767),
        title: Center(
          child: Text(
            "Accueil",
            style: TextStyle(fontSize: 25, color: Color(0xFFFFFFFF)),
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () => _DialoQuiterApp(context)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset("assets/images/home.png"),
              ),
              SizedBox(height: 20), // Espacement entre l'image et le texte
              Container(
                  // padding: EdgeInsets.all(16.0),
                  width: 345,
                  height: 246,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF5CA767), // Couleur de la bordure
                        width: 2.0, // Épaisseur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Text(
                        'Bienvenue !',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Sur G-ticket, une application qui vous permet d’envoyer "
                        "et d’obtenir de l’aide au problème liés à votre formation",
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/LoginPage");
                        },

                        child: Text(
                          "Conntez-vous",
                          style: TextStyle(fontSize: 16),
                        ),
                        //mise en form de bouton
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF5CA767),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

void _DialoQuiterApp(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fermer l'application"),
          content: Text('Est-vous sûr de quitter l\'application ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Non")),
            TextButton(
                onPressed: () {
                  exit(0);
                },
                child: Text("Oui"))
          ],
        );
      });
}
