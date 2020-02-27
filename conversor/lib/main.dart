import 'package:flutter/material.dart';

// Biblioteca que nos permite fazer as requisitções:
import 'package:http/http.dart' as http;
//   Import necessário para que possamos fazer uma requisição assíncrona,
// o que significa que não precisamos travar o App enquanto a resposta da
// requisição não chegar:
import 'package:async/async.dart';
// Para converter os dados em JSON:
import 'dart:convert';

// URL para fazer o request:
const request = 'https://api.hgbrasil.com/finance?format=json&key=5488bba6';

// O async simboliza que essa função será assíncrona.
main() async {
  runApp(
    MaterialApp(
      home: Home(),
      // ThemeData: define características de um tema.
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          // InputDecorationTheme: define a aparência dos InputDecoration.
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                // OutlineInputBorder: desenha um retângulo arredondado em torno do contêiner de InputDecorator.
                // BorderSide: um lado de uma borda de uma caixa.
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusColor: Colors.amber,
          ),
          cursorColor: Colors.amber,
          ),
    ),
  );
}

//   Future: usado para representar um valor potencial, ou erro, que estará disponível
// em algum momento no futuro.
Future<Map> getData() async {
  //   O await significa que ele vai esperar os dados chegarem, o programa não
  // trava enquanto os dados não chegam.
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

// StatefulWidget: widget que possui estado mutável.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "\$ Conversor \$",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      //   FutureBuilder: widget que se constrói com base no último snapshot de
      // interação com um futuro.
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // ConnectionState: O estado da conexão para uma computação assíncrona.
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar dados.",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amber,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"),
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      ),
                      // Divider: linha horizontal fina, com preenchimento de ambos os lados.
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Dólares",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"),
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Euros",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "€"),
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
