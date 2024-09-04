import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listenorepondu extends StatefulWidget {
  const Listenorepondu({super.key});

  @override
  State<Listenorepondu> createState() => _CateTechniqueState();
}

class _CateTechniqueState extends State<Listenorepondu> {
  late DateTime dateActuel;

  @override
  void initState() {
    super.initState();
    dateActuel = DateTime.now();
  }

  void _navigateDetailTicket() {
    Navigator.popAndPushNamed(context, '/Detailticket');
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
          "Liste des tickets non répondu",
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

          final tickets = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              var ticket = tickets[index];
              return InkWell(
                onTap: () => _navigateDetailTicket(),
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
                                //  _ShowDeleteDialog(ticket.id);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ticket['description'],
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
    );
  }
}
