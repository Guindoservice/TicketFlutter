import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Repondre extends StatefulWidget {
  final String title;
  final String description;
  final String id;
  final String status;
  const Repondre({
    super.key,
    required this.title,
    required this.description,
    required this.id,
    required this.status,
  });

  @override
  State<Repondre> createState() => _Repondre();
}

class _Repondre extends State<Repondre> {
  final _formkey = GlobalKey<FormState>();
  final _titlController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _titlController.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5CA767),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Navigator.popAndPushNamed(context, "/CateTechnique");
          },
        ),
        title: Center(
          child: Text(
            "Details Ticket",
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                "Ticket à répondre",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 16.0), // Margin pour décaler du bord gauche
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF312070)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                widget.description,
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF000000)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                child: ElevatedButton(
                  onPressed: _showForm,
                  child: Text(
                    'Répondre Ticket',
                    style: TextStyle(fontSize: 16),
                  ),
                  //mise en form de bouton
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF312070),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),

                      // Coins arrondis
                    ),
                    elevation: 8,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //***************************************
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
                      controller: _titlController,
                      decoration: InputDecoration(
                        labelText: 'Titre',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer un Titre'
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          labelText: 'Reponse ticket',
                          border: OutlineInputBorder()),
                      maxLines: 3,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez entrer une reponse'
                          : null,
                    ),
                    SizedBox(height: 20),
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
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    await _reponseTicket();
                  }
                  ;
                  Navigator.of(context)
                      .pop(); // Fermer le dialogue après la soumission
                }),
          ],
        );
      },
    );
  }

  Future<void> _reponseTicket() async {
    try {
      await FirebaseFirestore.instance.collection('ReponseTicket').add({
        'title': _titlController.text,
        'description': _descriptionController.text,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'Résolu',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ticket répondu avec succès')),
      );
      _titlController.clear();
      _descriptionController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la réponse au ticket')),
      );
    }
  }
}
