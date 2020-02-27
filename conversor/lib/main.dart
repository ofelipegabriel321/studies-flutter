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
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  _realChanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  _dolarChanged(String text) {
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "\$ Conversor \$",
          style: TextStyle(color: Colors.black),
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
                      buildTextField("Reais", "R\$", realController, _realChanged),
                      // Divider: linha horizontal fina, com preenchimento de ambos os lados.
                      Divider(),
                      buildTextField("Dólares", "US\$", dolarController, _dolarChanged),
                      Divider(),
                      buildTextField("Euros", "€", euroController, _euroChanged),
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

Widget buildTextField(String label, String prefix,
    TextEditingController controll, Function func) {
  return TextField(
    controller: controll,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: func,
  );
}
