import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //la appbar de bas
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFFFFF),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Color(0xFF5CA767),
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/Principale");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.update,
                color: Color(0xFF5CA767),
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/Historique");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Color(0xFF5CA767),
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/Apprenant");
              },
            )
          ],
        ),
      ),
      // fin AppBar De bas
    );
  }
}
