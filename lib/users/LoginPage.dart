import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _masquePassword = true;
  Future<void> _connect() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      // Connexion réussie, naviguer vers la page principale
      Navigator.popAndPushNamed(context, "/Principale");
    } catch (e) {
      // Afficher un message d'erreur à l'utilisateur
      print('Erreur de connexion : $e');
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

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
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ),
      ),
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
                child: Image.asset("assets/images/logoTicke.png"),
              ),
              Text(
                "Authentification",
                style: TextStyle(fontSize: 40),
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email, color: Color(0xFF312070)),
                ),
              ),
              TextFormField(
                controller: _password,
                obscureText: _masquePassword,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF312070)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _masquePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xFF312070),
                      ),
                      onPressed: () {
                        setState(() {
                          _masquePassword = !_masquePassword;
                        });
                      }),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _connect, // Appel de la méthode de connexion
                child: Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF312070),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Coins arrondis
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
