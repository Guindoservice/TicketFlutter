import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Formateurform extends StatefulWidget {
  const Formateurform({super.key});

  @override
  State<Formateurform> createState() => _FormateurformState(); // Renommé pour correspondre au widget
}

class _FormateurformState extends State<Formateurform> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  final List<String> _categories = [
    "TECHNIQUE",
    "PEDAGOGIQUE",
    "PRATIQUE",
    "THEORIQUE"
  ];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Ajout de la fonction pour vider les champs après soumission
  void _clearFormFields() {
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedCategory = null;
    });
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
            Navigator.popAndPushNamed(context, "/Detailticket");
          },
        ),
        title: Center(
          child: Text(
            "Formateur",
            style: TextStyle(fontSize: 25, color: Color(0xFFFFFFFF)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Répondre les questions en toute simplicité via le formulaire",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Titre',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un titre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        hint: Text('Choisissez une catégorie'),
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez choisir une catégorie';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Catégorie',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Enregistre'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF312070),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      String title = _titleController.text;
      String description = _descriptionController.text;
      String category = _selectedCategory!;

      try {
        await FirebaseFirestore.instance.collection('reponseTicket').doc().set({
          'title': title,
          'description': description,
          'category': category,
          'created_at': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Votre ticket a été soumis avec succès')),
        );
        _clearFormFields(); // Effacer les champs après soumission
      } catch (e) {
        print('Erreur lors de la sauvegarde des données : $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la soumission du ticket : $e')),
        );
      }
    } else {
      print("Formulaire non validé");
    }
  }

}
