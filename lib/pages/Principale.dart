import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_ticket/pages/ChatPage.dart';
import 'package:gestion_ticket/pages/Historique.dart';
import 'package:gestion_ticket/ticket/ReponseTicket.dart';

import '../categorie/CatTechnique.dart';
import '../ticket/ListeNoRepondu.dart';

class Principale extends StatefulWidget {
  const Principale({super.key});

  @override
  State<Principale> createState() => _PrincipaleState();
}

class _PrincipaleState extends State<Principale> {
  int _IndexSelect = 0;
// pour le choix des appbar en click
  void _OnTapIndex(int index) {
    setState(() {
      _IndexSelect = index;
    });

    // Navigation vers la page correspondante
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Principale()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Historique()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chatpage()),
        );
        break;
    }
  }

  void _Loginpage() {
    Navigator.pushNamed(context, '/LoginPage');
  }

  final List<String> listeImage = [
    'assets/images/Chat.png',
    'assets/images/message.png',
    'assets/images/Post.png',
    'assets/images/Online.png',
    'assets/images/home.png',
  ];
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
            Navigator.popAndPushNamed(context, "/LoginPage");
          },
        ),
        title: Center(
          child: Text(
            "Catégorie",
            style: TextStyle(fontSize: 25, color: Color(0xFFFFFFFF)),
          ),
        ),
        //bouton pour afficher le pop des users
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 300,
                      color: Color(0xFF5CA767),
                      child: Center(
                        child: Column(
                          children: [
                            // choix des users
                            InkWell(
                              onTap: _Loginpage,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFFFFFFFF),
                                              width: 3))),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: Color(
                                        0xFF312776,
                                      ),
                                      size: 40,
                                    ),
                                    title: Text(
                                      "Formateur",
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                  )),
                            ),
                            // Compte Apprenant
                            InkWell(
                              onTap: _Loginpage,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFFFFFFFF),
                                              width: 3))),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: Color(
                                        0xFF312776,
                                      ),
                                      size: 40,
                                    ),
                                    title: Text(
                                      "Apprenant",
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Aligne les éléments en haut
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centre l'image horizontalement

          children: [
            //pour le slider les images
            SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items: listeImage.map((imagepath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFF5CA767), width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagepath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      child: Text(
                        "Liste Ticket",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5CA767),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Coins arrondis
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Listenorepondu()),
                        );
                      }),
                  // boutton 2 *********************************************************************************
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      child: Text(
                        "Liste Reponse",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF312070),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Coins arrondis
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reponseticket()));
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  //**********************************
                  ElevatedButton(
                      child: Text(
                        "TECHNIQUE",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5CA767),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Coins arrondis
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CateTechnique(
                                      id: '',
                                    )));
                      }),
                  // boutton 2 *********************************************************************************
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      child: Text(
                        "PEDAGOGIQUE",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF312070),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Coins arrondis
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Catpedagogique');
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      child: Text(
                        "PRATIQUE",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5CA767),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Coins arrondis
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, '/CatPratique');
                      }),
                  // boutton 2 *********************************************************************************
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      child: Text(
                        "THEORIQUE",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF312070),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Coins arrondis
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Cattheorique');
                      }),
                ],
              ),
            ), //DEUXIEME LIGNE ************************************************************************
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF312070),
        onPressed: () {
          Navigator.popAndPushNamed(context, '/Apprenantform');
        },
        child: Icon(
          Icons.add,
          color: Color(0xFFFFFFFF),
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
