import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Detailticket extends StatefulWidget {
  final String title;
  final String description;
  final String id;
  final String status;
  const Detailticket({
    super.key,
    required this.title,
    required this.description,
    required this.id,
    required this.status,
  });

  @override
  State<Detailticket> createState() => _DetailticketState();
}

class _DetailticketState extends State<Detailticket> {
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
          ],
        ),
      ),
    );
  }

  //***************************************
}
