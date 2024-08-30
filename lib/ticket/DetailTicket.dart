import 'package:flutter/material.dart';

class Detailticket extends StatefulWidget {
  const Detailticket({super.key});

  @override
  State<Detailticket> createState() => _DetailticketState();
}

class _DetailticketState extends State<Detailticket> {
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
                "Titre",
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
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Ducimus quam numquam possimus exercitationem"
                " labore vero itaque laborum omnis assumenda ipsam illo, sapiente tenetur odit nesciunt quaerat corrupti,"
                " alias neque accusantium. Lorem ipsum dolor sit amet consectetur adipisicing elit. Ducimus quam "
                "numquam possimus exercitationem labore vero itaque laborum omnis assumenda"
                " ipsam illo, sapiente tenetur odit nesciunt quaerat corrupti, alias neque accusantium.",
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
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/Formateurform');
                  },
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
}
