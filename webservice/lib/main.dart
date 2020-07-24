import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Future<Movie> fetchPost() async {
  final response =
  await http.get('http://www.omdbapi.com/?i=tt3896198&apikey=e58bb080');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return Movie.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

//clase que recibe el contenido del Json y los presenta como propiedades separadas
class Movie {
  final String year;
  final String genre;
  final String title;
  final String rate;
  final String runtime;

  Movie({this.year, this.genre, this.title, this.rate, this.runtime});

  //En esta parte copiamos el json a cada una de las propiedades del objeto
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      year: json['Year'],
      genre: json['Genre'],
      title: json['Title'],
      rate: json['Rated'],
      runtime: json['Runtime'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Movie> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Movie>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Película:\n Título:  ${snapshot.data.title}\n Duración: ${snapshot.data.runtime} "
                    "\n: Género: ${snapshot.data.genre} \n Año: ${snapshot.data.year} \n Clasificación ${snapshot.data.rate}");
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // Por defecto, muestra un loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}