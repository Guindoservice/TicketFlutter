import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Principale extends StatefulWidget {
  const Principale({super.key});

  @override
  State<Principale> createState() => _PrincipaleState();
}

class _PrincipaleState extends State<Principale> {
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
            "G-Ticket",
            style: TextStyle(fontSize: 25, color: Color(0xFFFFFFFF)),
          ),
        ),
      ),
      body: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  child: Text(
                    "TECHNIQUE",
                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5CA767),
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Coins arrondis
                      )),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/CateTechnique');
                  }),
              // boutton 2 *********************************************************************************
              SizedBox(
                width: 7,
              ),
              ElevatedButton(
                  child: Text(
                    "PEDAGOGIQUE",
                    style: TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5CA767),
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Coins arrondis
                      )),
                  onPressed: () {}),
            ],
          ),
          //DEUXIEME LIGNE ************************************************************************
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  child: Text(
                    "PRATIQUE",
                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5CA767),
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Coins arrondis
                      )),
                  onPressed: () {}),
              // boutton 2 *********************************************************************************
              SizedBox(
                width: 7,
              ),
              ElevatedButton(
                  child: Text(
                    "THEORIQUE",
                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5CA767),
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // Coins arrondis
                      )),
                  onPressed: () {}),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5CA767),
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
