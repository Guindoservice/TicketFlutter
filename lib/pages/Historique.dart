import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _CateTechniqueState();
}

class _CateTechniqueState extends State<Historique> {
  int _IndexSelect = 0;
  void _OnTapIndex(int index) {
    setState(() {
      _IndexSelect = index;
    });
    switch (index) {
      case 0:
        Navigator.popAndPushNamed(context, "/Principale");
        break;
      case 1:
        Navigator.popAndPushNamed(context, "/Historique");
        break;
      case 2:
        Navigator.popAndPushNamed(context, "/User");
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
    final _recherche;
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
          "Historique",
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
                    Text(
                      "Titre du ticket",
                      style: TextStyle(
                          color: Color(0xFF312070),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
            Container(
              decoration: BoxDecoration(
                color:
                    _IndexSelect == 0 ? Color(0xFF5CA767) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color:
                      _IndexSelect == 0 ? Color(0xFFFFFFFF) : Color(0xFF5CA767),
                ),
                onPressed: () => _OnTapIndex(0),
                iconSize: 30,
                padding: EdgeInsets.all(12.0),
                splashRadius: 20.0,
                splashColor: Colors.transparent,
                constraints: BoxConstraints(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color:
                    _IndexSelect == 1 ? Color(0xFF5CA767) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.update,
                  color:
                      _IndexSelect == 1 ? Color(0xFFFFFFFF) : Color(0xFF5CA767),
                ),
                onPressed: () => _OnTapIndex(1),
                iconSize: 30,
                padding: EdgeInsets.all(12.0),
                splashRadius: 20.0,
                splashColor: Colors.transparent,
                constraints: BoxConstraints(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color:
                    _IndexSelect == 2 ? Color(0xFF5CA767) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color:
                      _IndexSelect == 2 ? Color(0xFFFFFFFF) : Color(0xFF5CA767),
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
