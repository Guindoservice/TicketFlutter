import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Cattheorique extends StatefulWidget {
  const Cattheorique({super.key});

  @override
  State<Cattheorique> createState() => _CattheoriqueState();
}

class _CattheoriqueState extends State<Cattheorique> {
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
          "Théorique",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: _navigateDetailTicket,
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
                          "Titre du ticket",
                          style: TextStyle(
                              color: Color(0xFF312070),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          'EN_COURS',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Desciption du ticket",
                      style: TextStyle(color: Color(0xFF312070), fontSize: 15),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${DateFormat('dd-MM-yyyy').format(dateActuel)}",
                        style: TextStyle(color: Color(0xFF5CA767)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                  Icons.chat,
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
