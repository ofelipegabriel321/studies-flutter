import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //   Scaffold: implementa a estrutura de layout visual básica do material design,
    // fornecendo boas estruturas para montar barras e botões do app
    return Scaffold(
        // AppBar: AppBar: implementa uma barra de ferramentas (podendo até conter outros widgets)
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            // IconButton: um botão com icone.
            IconButton(
              // Icon: widget de ícone gráfico desenhado.
              // Icons: widget de ícone.
              icon: Icon(Icons.refresh),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.white,
        //   SingleChildScrollView: garante que o container de um filho seja rolável quando a
        // tela estiver muito pequena para ele (na direção da rolagem).
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              // TextField: campo de texto do material design.
              TextField(
                // TextInputType: tipo de informação do input.
                keyboardType: TextInputType.number,
                //   InputDecoration: border, labels, icons e os styles usados ​​para
                // decorar um TextField do material design.
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    // TextStyle: define o size, position e color do texto.
                    labelStyle: TextStyle(color: Colors.green)),
                // TextAlign: tipo de alinhamento a ser aplicado em um texto.
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  // padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  //   Tentei fazer isso, mas isso geraria um padding no child em relação ao container, ou seja,
                  // o child ia ocupar 30 desse 50 de altura, mas eu quero é que o padding seja aplicado para
                  // fora do container.
                  height: 50.0,
                  //   RaisedButton: classe que define um botão com um texto.“botão elevado”: aqui queremos
                  // passar a sensação de ter elevação no botão em relação ao seu pai, por isso a cor do
                  // conteúdo do botão é escurecida e ele possui uma sombra no entorno.
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                "Info",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ));
  }
}
