import 'package:cloud_firestore/cloud_firestore.dart';
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
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () => Navigator.popAndPushNamed(context, "/Principale"),
        ),
        title: Center(
          child: Text("Formulaire Ticket",
              style: TextStyle(fontSize: 25, color: Color(0xFFFFFFFF))),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    "Posez vos questions en toute simplicité via le formulaire",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),

                // Champ Titre
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: 'Titre', border: OutlineInputBorder()),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Veuillez entrer un titre'
                      : null,
                ),
                SizedBox(height: 16),

                // Champ Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Description', border: OutlineInputBorder()),
                  maxLines: 3,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Veuillez entrer une description'
                      : null,
                ),
                SizedBox(height: 16),

                // Champ Catégorie
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: Text('Choisissez une catégorie'),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                          value: category, child: Text(category)))
                      .toList(),
                  onChanged: (newValue) =>
                      setState(() => _selectedCategory = newValue),
                  validator: (value) =>
                      (value == null) ? 'Veuillez choisir une catégorie' : null,
                  decoration: InputDecoration(
                      labelText: 'Catégorie', border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),

                // Champ Statut

                SizedBox(height: 20),

                // Bouton Soumettre
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _soumettreTicket();
                    }
                  },
                  child: Text('Envoyer'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF5CA767),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _soumettreTicket() async {
    try {
      await FirebaseFirestore.instance.collection('tickets').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'createdAt': Timestamp.now(),
        'status': 'En attente',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ticket soumis avec succès')),
      );
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la soumission du ticket')),
      );
    }
  }
}
