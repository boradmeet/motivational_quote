import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const HomePage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List quotes = [];

  loadJsonData() async {
    String json =
        await rootBundle.loadString("assets/motivational_quotes.json");

    quotes = jsonDecode(json);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
          centerTitle: true,
          title: const Text("Motivational quote")),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: quotes.length,
        itemBuilder: (context, i) => GestureDetector(
          onTap: () {
            showDialog(
              barrierColor: Colors.lightGreen,
              context: context,
              builder: (context) => AlertDialog(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                scrollable: true,
                backgroundColor: Colors.lightGreen,
                title: Center(child: Text("${quotes[i]["quoteAuthor"]}")),
                content: Center(child: Text("${quotes[i]["quoteText"]}")),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.greenAccent,
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "~ ${quotes[i]["quoteText"]}",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: 1.5,
                      wordSpacing: 2,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "- ${quotes[i]["quoteAuthor"]}",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
