import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data {
  String? from;
  String? to;
  List<Generationmix?>? generationmix;

  Data({this.from, this.to, this.generationmix});
}

class Generationmix {
  String? fuel;
  double? perc;

  Generationmix({this.fuel, this.perc});
}

class User {
  final String name;
  final String email;
  final String username;

  User({this.name = " ", this.email = " ", this.username = " "});
}

class httpfile extends StatefulWidget {
  const httpfile({Key? key}) : super(key: key);

  @override
  _httpfileState createState() => _httpfileState();
}

class _httpfileState extends State<httpfile> {
  Future<List<Generationmix>> getUserData() async {
    String url = "https://api.carbonintensity.org.uk/generation";
    final response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    List<Generationmix> users = [];

    for (var u in jsonData) {
      Generationmix user = Generationmix(fuel: u["fuel"], perc: u["fuel"]);
      users.add(user);
    }
    return users;
  }

// name: u["name"], email: u["email"], username: u["username"]

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: FutureBuilder(
          future: getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: const Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(snapshot.data[i].fuel),
                  subtitle: Text(snapshot.data[i].perc),
                  //   trailing: Text(snapshot.data[i].email),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
