import 'dart:async';
import 'dart:convert';

import 'datamodel.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Intensity> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.carbonintensity.org.uk/intensity/date'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Intensity.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Api2 extends StatefulWidget {
  const Api2({super.key});

  @override
  State<Api2> createState() => _MyAppState();
}

class _MyAppState extends State<Api2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Fetch Data Example',
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Container(
                    width: 500,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.topCenter,
                    child: const Column(children: [
                      Text(
                        "National carbon intensity",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.black,
                        ),
                      ),
                      carbon(),
                      Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            children: [
                              Text(
                                '''Carbon intensity is high maybe    
take a break and
read a book instead''',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Text(
                                "High",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )),
                    ])),
              )
            ],
          )),
    );
  }
}

class carbon extends StatefulWidget {
  const carbon({super.key});

  @override
  State<carbon> createState() => _carbonState();
}

class _carbonState extends State<carbon> {
  late Future<Intensity> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Intensity>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.actual.toString());
          } else if (snapshot.hasError) {}

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
