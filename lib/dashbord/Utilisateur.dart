import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_ticket/dashbord/Apprenant.dart';
import 'package:gestion_ticket/dashbord/Categorie.dart';
import 'package:gestion_ticket/dashbord/Historiques.dart';

class Utilisateur extends StatefulWidget {
  const Utilisateur({super.key});

  @override
  State<Utilisateur> createState() => _DashbordState();
}

class _DashbordState extends State<Utilisateur> {
  // les attribut du formulaire
  //final TextEditingController _photo = TextEditingController();
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String? _selcteRole;
  bool _isSubmitting = true;
  final List<String> _role = ['FORMATEUR', 'APPRENANT '];
  /*Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      String filePath = result.files.single.path ?? '';
      setState(() {
        _photo.text = filePath;
      });
    }
  } */
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
        'password': _password.text,
        'role': _selcteRole,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Utilisateur créé avec succès'),
        ),
      );
      _nom.clear();
      _prenom.clear();
      _contact.clear();
      _email.clear();
      _password.clear();
      _selcteRole = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la création de l\'utilisateur: $e'),
        ),
      );
    }
  }

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
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/Accueil');
                }),
            Text(
              'Accueil',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Utilisateur()),
                  );
                }),
            Text(
              'Utilisateur',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Apprenant()),
                  );
                }),
            Text(
              'Apprenant',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.category,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Categorie()),
                  );
                }),
            Text(
              'Catégorie',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.update,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Historiques()),
                  );
                }),
            Text(
              'Historique',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
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
                    onPressed: () {
                      _showForm();
                    },
                    child: Text(
                      "Nouveau",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFFFFFFF),
                      backgroundColor: Color(0xFF5AC767),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
              width: double
                  .infinity, // Utilisez double.infinity pour que le conteneur prenne toute la largeur disponible
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF312070),
                    width: 4,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Espace entre le conteneur et le tableau
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: DataTable(
                columns: const <DataColumn>[
                  // DataColumn(label: Text("Photo")),
                  DataColumn(label: Text("Nom")),
                  DataColumn(label: Text("Prenom")),
                  DataColumn(label: Text("Contact")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Mot de passe")),
                  DataColumn(label: Text("Action")),
                ],
                rows: <DataRow>[
                  DataRow(cells: <DataCell>[
                    // DataCell(Image.asset('assets/images/abblo.png', width: 40, height: 40)),
                    DataCell(Text("Celina")),
                    DataCell(Text("Diarra")),
                    DataCell(Text("76541123")),
                    DataCell(Text("celina@gmail.com")),
                    DataCell(Text("*******")),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xFF5AC767),
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xFF312070),
                          ),
                          onPressed: () {},
                        )
                      ],
                    )),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // la fonction pour ouvrir le dialog messeage
  void _showForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Le formulaire'),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Form(
                key: _formkey,
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
                      obscureText: true, // Masquer le mot de passe
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer un mot de passe'
                          : null,
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selcteRole,
                      hint: Text('Choisissez le Rôle'),
                      items: _role
                          .map((category) => DropdownMenuItem(
                              value: category, child: Text(category)))
                          .toList(),
                      onChanged: (newValue) =>
                          setState(() => _selcteRole = newValue),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Enregistrer'),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
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
