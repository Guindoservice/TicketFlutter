import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ticket/DetailTicket.dart';

class Catpedagogique extends StatefulWidget {
  final String id;
  final String description;
  const Catpedagogique(
      {super.key, required this.id, required this.description});

  @override
  State<Catpedagogique> createState() => _CateTechniqueState();
}

class _CateTechniqueState extends State<Catpedagogique> {
  int _IndexSelect = 0;

  void _OnTapIndex(int index) {
    setState(() {
      _IndexSelect = index;
    });

    // Navigation vers la page correspondante
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, "/Principale");
        break;
      case 1:
        Navigator.pushReplacementNamed(context, "/Historique");
        break;
      case 2:
        Navigator.pushReplacementNamed(context, "/User");
        break;
    }
  }

  late DateTime dateActuel;

  @override
  void initState() {
    super.initState();
    dateActuel = DateTime.now();
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
        title: Text(
          "Technique",
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .where('category', isEqualTo: 'PEDAGOGIQUE')
            .snapshots(),
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

          final tickets = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              var ticket = tickets[index];
              String truncatedDescription = ticket['description'].length > 50
                  ? ticket['description'].substring(0, 50) + '...'
                  : ticket['description'];

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
                        //Titre
                        Row(
                          children: <Widget>[
                            Text(
                              ticket['title'],
                              style: TextStyle(
                                  color: Color(0xFF312070),
                                  fontSize: 20,
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
                                  fontSize: 16,
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          truncatedDescription,
                          style:
                              TextStyle(color: Color(0xFF312070), fontSize: 15),
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
      //la appbar de bas

      // fin AppBar De bas
    );
  }

  Future<void> _navigateDetailTicket(DocumentSnapshot ticket) async {
    //mettre en cours le statut du ticket
    await FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticket.id)
        .update({'status': 'En cours'});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detailticket(
          title: ticket['title'],
          description: ticket['description'],
          id: ticket.id,
          status: '',
        ),
      ),
    );
  }

  // pour supprimer un ticket
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
