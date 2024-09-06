import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'DetailTicket.dart';
import 'Repondre.dart';

class Listenorepondu extends StatefulWidget {
  final String description;
  final String title;
  const Listenorepondu(
      {super.key, required this.description, required this.title});

  @override
  State<Listenorepondu> createState() => _CateTechniqueState();
}

class _CateTechniqueState extends State<Listenorepondu> {
  late DateTime dateActuel;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _allTickets = [];
  List<DocumentSnapshot> _filteredTickets = [];

  @override
  void initState() {
    super.initState();
    dateActuel = DateTime.now();
  }

  Future<void> _navigateDetailTicket(DocumentSnapshot ticket) async {
    await FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticket.id)
        .update({'status': 'En cours'});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Repondre(
          title: ticket['title'],
          description: ticket['description'],
          id: ticket.id,
          status: '',
        ),
      ),
    );
  }

  void _filterTickets(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredTickets = _allTickets;
      });
    } else {
      setState(() {
        _filteredTickets = _allTickets.where((ticket) {
          final title = ticket['title'].toString().toLowerCase();
          return title.contains(query.toLowerCase());
        }).toList();
      });
    }
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
            Navigator.popAndPushNamed(context, "/Principale");
          },
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: TextStyle(color: Color(0xFF800080)),
                decoration: InputDecoration(
                  hintText: "Recherche...",
                  hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                  ),
                ),
                onChanged: _filterTickets,
              )
            : Text(
                "Liste des tickets non répondu",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filteredTickets = _allTickets; // Réinitialiser la liste
                }
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des tickets'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucun ticket disponible'));
          }

          // Initialiser _allTickets seulement lors du chargement des données
          if (_allTickets.isEmpty) {
            _allTickets = snapshot.data!.docs;
            _filteredTickets = _allTickets; // Initialiser _filteredTickets
          }

          return ListView.builder(
            itemCount: _filteredTickets.length,
            itemBuilder: (context, index) {
              var ticket = _filteredTickets[index];
              String truncatedDescription = ticket['description'].length > 50
                  ? ticket['description'].substring(0, 50) + '...'
                  : ticket['description'];
              String truncatedTitle = ticket['title'].length > 8
                  ? ticket['title'].substring(0, 8) + '...'
                  : ticket['title'];

              return InkWell(
                onTap: () => _navigateDetailTicket(ticket),
                child: Card(
                  margin: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              truncatedTitle,
                              style: TextStyle(
                                  color: Color(0xFF312070),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              ticket['status'],
                              style: TextStyle(
                                  color: ticket['status'] == 'En attente'
                                      ? Colors.orange
                                      : ticket['status'] == 'En cours'
                                          ? Colors.red
                                          : Colors.green,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Color(0xFF5AC767)),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.delete, color: Color(0xFF312070)),
                              onPressed: () {
                                _ShowDeleteDialog(ticket.id);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          truncatedDescription,
                          style:
                              TextStyle(color: Color(0xFF312070), fontSize: 16),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${DateFormat('dd-MM-yyyy').format(ticket['createdAt'].toDate())}",
                            style: TextStyle(color: Color(0xFF5CA767)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteTicket(String id) async {
    try {
      await FirebaseFirestore.instance.collection('tickets').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ticket supprimé avec succès'),
          backgroundColor: Color(0xFF5CA767),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression du ticket'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _ShowDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir supprimer ce ticket ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              child: Text('Supprimer'),
              onPressed: () async {
                await _deleteTicket(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
