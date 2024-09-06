import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chatpage extends StatefulWidget {
  final String chatId; // ID de la conversation
  const Chatpage({super.key, required this.chatId});

  @override
  State<Chatpage> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chatpage> {
  final _chatController = TextEditingController();
  late DateTime _currentDateTime;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _currentDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5CA767),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        title: Text("Discussion", style: TextStyle(color: Color(0xFFFFFFFF))),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Color(0xFFFFFFFF)),
            onPressed: () {
              // Ajoutez ici la logique pour supprimer la conversation
            },
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Color(0xFFFFFFFF)),
            onPressed: () {
              // Ajoutez ici la logique pour supprimer la conversation
            },
          ),
          IconButton(
            icon: Icon(Icons.camera, color: Color(0xFFFFFFFF)),
            onPressed: () {
              // Ajoutez ici la logique pour supprimer la conversation
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("conversations")
            .doc(widget.chatId)
            .collection("messages")
            .orderBy("CreatAt")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshots.hasError) {
            return Center(child: Text("Erreur de chargement des messages"));
          }
          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return Center(child: Text("Aucun message disponible"));
          }
          final messages = snapshots.data!.docs;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              Timestamp timestamp = message['CreatAt'];
              DateTime messageTime = timestamp.toDate();
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFDFF2FF),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        message['text'],
                        softWrap: true,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF312070)),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${messageTime.hour}:${messageTime.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 10, color: Color(0xFF000000)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFFFFF),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _chatController,
                decoration: InputDecoration(
                  hintText: "Tapez votre message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Color(0xFF5CA767)),
                  ),
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(150)],
              ),
            ),
            SizedBox(width: 5),
            Container(
              child: IconButton(
                icon: Icon(Icons.send, size: 30, color: Color(0xFFFFFFFF)),
                onPressed: _sendMessage,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF312070),
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final message = _chatController.text.trim();
    if (message.isEmpty) return;

    final userId =
        _auth.currentUser?.uid; // Récupération de l'ID de l'utilisateur
    if (userId == null) {
      print("Erreur : utilisateur non authentifié");
      return;
    }

    // Créez un nouvel objet de message
    final newMessage = {
      'text': message,
      'CreatAt': Timestamp.fromDate(DateTime.now()),
      'senderId': userId,
      'status': 'non lue',
    };

    try {
      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(widget.chatId)
          .collection('messages')
          .add(newMessage);
    } catch (e) {
      print("Erreur lors de l'envoi du message : $e");
    }

    _chatController.clear();
  }
}
