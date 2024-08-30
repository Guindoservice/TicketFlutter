import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reponseticket extends StatefulWidget {
  const Reponseticket({super.key});

  @override
  State<Reponseticket> createState() => _CateTechniqueState();
}

class _CateTechniqueState extends State<Reponseticket> {
  late DateTime dateActuel;

  @override
  void initState() {
    super.initState();
    dateActuel = DateTime.now();
  }

  void _navigateDetailTicket() {
    Navigator.popAndPushNamed(context, '/DetailReponse');
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
            Navigator.popAndPushNamed(context, "/Formateurform");
          },
        ),
        title: Text(
          "Liste réponses",
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
    );
  }
}
