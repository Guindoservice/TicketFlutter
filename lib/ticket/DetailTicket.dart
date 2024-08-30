import 'package:flutter/material.dart';

class Detailticket extends StatefulWidget {
  const Detailticket({super.key});

  @override
  State<Detailticket> createState() => _DetailticketState();
}

class _DetailticketState extends State<Detailticket> {
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
      //la appbar de bas
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFFFFF),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Bouton Home
            Container(
              decoration: BoxDecoration(
                color:
                    _IndexSelect == 0 ? Color(0xFF5CA767) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: _IndexSelect == 0 ? Colors.white : Color(0xFF5CA767),
                ),
                onPressed: () => _OnTapIndex(0),
                iconSize: 30,
                padding: EdgeInsets.all(12.0),
                splashRadius: 20.0,
                splashColor: Colors.transparent,
                constraints: BoxConstraints(),
              ),
            ),
            // Bouton Historique
            Container(
              decoration: BoxDecoration(
                color:
                    _IndexSelect == 1 ? Color(0xFF5CA767) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.update,
                  color: _IndexSelect == 1 ? Colors.white : Color(0xFF5CA767),
                ),
                onPressed: () => _OnTapIndex(1),
                iconSize: 30,
                padding: EdgeInsets.all(12.0),
                splashRadius: 20.0,
                splashColor: Colors.transparent,
                constraints: BoxConstraints(),
              ),
            ),
            // Bouton User
            Container(
              decoration: BoxDecoration(
                color:
                    _IndexSelect == 2 ? Color(0xFF5CA767) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: _IndexSelect == 2 ? Colors.white : Color(0xFF5CA767),
                ),
                onPressed: () => _OnTapIndex(2),
                iconSize: 30,
                padding: EdgeInsets.all(12.0),
                splashRadius: 20.0,
                splashColor: Colors.transparent,
                constraints: BoxConstraints(),
              ),
            ),
          ],
        ),
      ),
      // fin AppBar De bas
    );
  }
}
