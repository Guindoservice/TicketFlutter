import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color persianIndigo = Color(0xFF5CA767);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, "/Homepage");
            },
          ),
          backgroundColor: persianIndigo,
          title: Center(
            child: Text(
              "Page d'authentification",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  "assets/images/logoTicke.png",
                ),
              ),
              Container(
                child: Text(
                  "Authentification",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    labelText: "Nom d'utilisateur",
                    prefixIcon: Icon(Icons.person, color: Color(0xFF312070)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nom d\'utilisateur est incorect Veillez ressayer ';
                    }
                    return null;
                  }),
              TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                      labelText: "Mot de passe",
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF312070)),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: Color(0xFF312070),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mot de passe incorect veillez saissir un mot de pase correct";
                    }
                    return null;
                  }),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/Principale");
                },
                child: Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 20),
                ),
                //mise en form de bouton
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF312070),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Coins arrondis
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // login de la connexion
}
