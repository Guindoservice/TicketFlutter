import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_ticket/dashbord/Accueil.dart';
import 'package:gestion_ticket/pages/Principale.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _masquePassword = true;
  String? _roles;
  Future<void> _connect() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      // reccuperer le role de l'utilisateur conecter'
      User? user = userCredential.user;
      if (user != null) {
        _getUserRole(user.uid);
      }
    } catch (e) {
      // Afficher un message d'erreur à l'utilisateur
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _getUserRole(String uid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Utilisateur')
          .doc(uid)
          .get();
      String? role = snapshot['role'];
      if (role == 'ADMIN') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashbord()));
      } else if (role == 'FORMATEUR' || role == 'APPRENANT') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Principale()));
      } else {
        _showErrorDialog(
            "Vous n'avez pas le droit d'acceder à cette application");
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Erreur !'),
        content: Text("Veillez verifier votre email ou mot de passe"),
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
                            ? Icons.visibility_off
                            : Icons.visibility,
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
