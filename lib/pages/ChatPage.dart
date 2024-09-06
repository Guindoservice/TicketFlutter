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
    _getApprenantData;
    _currentDateTime = DateTime.now();
    _sendMessage();
  }

  // pour diviser la page entre les apprenants
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? apprenantData;
  Future<void> _sendMessage() async {
    final message = _chatController.text.trim();
    if (message.isEmpty) return;

    final userId = _auth
        .currentUser?.uid; // Récupération de l'UID de l'utilisateur connecté
    if (userId == null) {
      print("Erreur : utilisateur non authentifié");
      return;
    }

    // Créez un nouvel objet de message avec l'UID de l'utilisateur
    final newMessage = {
      'text': message,
      'CreatAt': Timestamp.fromDate(DateTime.now()),
      'senderId': userId, // Ajoute l'UID de l'utilisateur comme expéditeur
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

  Future<void> _getApprenantData() async {
    if (user != null) {
      DocumentSnapshot apprenantSnapshot = await FirebaseFirestore.instance
          .collection('Utilisateur')
          .doc(user!.uid)
          .get();

      if (apprenantSnapshot.exists) {
        setState(() {
          apprenantData = apprenantSnapshot.data() as Map<String, dynamic>;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5CA767),
        title: Text(
          apprenantData != null
              ? "${apprenantData!['prennom']} "
              : "Chargement...",
          style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
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
                  return Center(
                      child: Text("Erreur de chargement des messages"));
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

                    // Récupération de l'UID de l'expéditeur
                    final senderId = message['senderId'];
                    final currentUserId = _auth.currentUser?.uid;

                    // Vérification si le message a été envoyé par l'utilisateur courant ou l'autre
                    bool isCurrentUser = senderId == currentUserId;

                    return Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isCurrentUser
                              ? Color(0xFF5CA767)
                              : Color(0xFFDFF2FF),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['text'],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: isCurrentUser
                                      ? Colors.white
                                      : Color(0xFF312070)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${messageTime.hour}:${messageTime.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
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
              onPressed: _sendMessages,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF312070),
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessages() async {
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
