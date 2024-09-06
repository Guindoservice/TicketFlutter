import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_ticket/dashbord/Historiques.dart';
import 'package:gestion_ticket/pages/ChatPage.dart';

import '../pages/Principale.dart';
import 'Accueil.dart';

class Utilisateur extends StatefulWidget {
  const Utilisateur({Key? key}) : super(key: key);

  @override
  State<Utilisateur> createState() => _UtilisateurState();
}

class _UtilisateurState extends State<Utilisateur> {
  // Les attributs du formulaire
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _formation = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _masquePassword = true;
  String? _selectedRole;
  final List<String> _roles = ['FORMATEUR', 'ADMIN', 'APPRENANT'];

  Future<void> _creeUser() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      String userId = userCredential.user!.uid;
      await _firestore.collection('Utilisateur').doc(userId).set({
        'nom': _nom.text,
        'prenom': _prenom.text,
        'contact': _contact.text,
        'email': _email.text,
        'formation': _formation.text,
        'role': _selectedRole,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Utilisateur créé avec succès')),
      );

      // Nettoyer les champs
      _nom.clear();
      _prenom.clear();
      _contact.clear();
      _email.clear();
      _password.clear();
      _formation.clear();
      _selectedRole = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur lors de la création de l\'utilisateur: $e')),
      );
    }
  }

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
                    MaterialPageRoute(
                        builder: (context) => Chatpage(
                              chatId: '',
                            )),
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
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "Liste des formateurs",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF312070),
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _showForm,
                    child: Text("Nouveau", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF5AC767),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 10),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFF312070), width: 4)),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Utilisateur').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Erreur de récupération des utilisateurs');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final utilisateurs = snapshot.data!.docs;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text("Nom")),
                      DataColumn(label: Text("Prenom")),
                      DataColumn(label: Text("Contact")),
                      DataColumn(label: Text("Email")),
                      DataColumn(label: Text("Formation")),
                      DataColumn(label: Text("Rôle")),
                      DataColumn(label: Text("Action")),
                    ],
                    rows: utilisateurs.map((user) {
                      return DataRow(cells: [
                        DataCell(Text(user['nom'])),
                        DataCell(Text(user['prenom'])),
                        DataCell(Text(user['contact'])),
                        DataCell(Text(user['email'])),
                        DataCell(Text(user['formation'])),
                        DataCell(Text(user['role'])),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Color(0xFF5AC767)),
                              onPressed: () {
                                // Action pour éditer l'utilisateur
                              },
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.delete, color: Color(0xFF312070)),
                              onPressed: () {
                                // Action pour supprimer l'utilisateur
                              },
                            )
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Le formulaire')),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nom,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer un nom'
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _prenom,
                      decoration: InputDecoration(
                        labelText: 'Prenom',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer le prénom'
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _contact,
                      decoration: InputDecoration(
                        labelText: 'Contact',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer un contact'
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _password,
                      obscureText: _masquePassword,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(),
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
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer un mot de passe'
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _formation,
                      decoration: InputDecoration(
                        labelText: 'Fomation',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer une fomation'
                          : null,
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      hint: Text('Choisissez le Rôle'),
                      items: _roles
                          .map((role) =>
                              DropdownMenuItem(value: role, child: Text(role)))
                          .toList(),
                      onChanged: (newValue) =>
                          setState(() => _selectedRole = newValue),
                      validator: (value) =>
                          (value == null) ? 'Veuillez choisir un rôle' : null,
                      decoration: InputDecoration(
                        labelText: 'Rôle',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Annuler"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Enregistrer'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _creeUser();
                  Navigator.of(context)
                      .pop(); // Fermer le dialogue après la soumission
                }
              },
            ),
          ],
        );
      },
    );
  }
}
