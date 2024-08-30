import 'package:flutter/material.dart';

class Apprenantform extends StatefulWidget {
  const Apprenantform({super.key});

  @override
  State<Apprenantform> createState() => _ApprenantformState();
}

class _ApprenantformState extends State<Apprenantform> {
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
            Navigator.popAndPushNamed(context, "/Principale");
          },
        ),
        title: Center(
          child: Text(
            "Formulaire Ticket",
            style: TextStyle(fontSize: 25, color: Color(0xFFFFFFFF)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Texte en haut
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Posez vos questions en toute simplicité via le formulaire",
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Formulaire en bas
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Champ Titre
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
                      // Champ Description
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
                      // Champ Catégorie
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
                      // Bouton Soumettre
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Traiter les données du formulaire
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Votre ticket a été soumises avec succès')),
                            );
                            // Vous pouvez accéder aux valeurs des champs ici
                            print('Titre: ${_titleController.text}');
                            print(
                                'Description: ${_descriptionController.text}');
                            print('Catégorie: $_selectedCategory');
                          }
                        },
                        child: Text('Envoyer'),
                        //mise en form de bouton
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF5CA767),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),

                            // Coins arrondis
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
}
