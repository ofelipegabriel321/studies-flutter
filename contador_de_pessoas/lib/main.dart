// import necessário para o runApp(app)
import 'package:flutter/material.dart';

void main() {
  runApp(
      // MaterialApp: widget necessário para que o App suporte widgets do Material Design.
      MaterialApp(
          title: "Contador de pessoas",
          // Stack: widget que posiciona seus filhos em relação às bordas de sua caixa.
          home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<String> _possibleInfoTexts = [
    "Pode Entrar!",
    "Todos já saíram!",
    "Lotado!"
  ];

  int _people = 0;
  String _infoText = _possibleInfoTexts[0];

  void _changePeople(int delta) {
    // setState: executa uma função e depois atualiza o que for necessário na tela.
    setState(() {
      if (_people <= 0 && delta == -1) {
        _infoText = _possibleInfoTexts[1];
      } else if (_people >= 10 && delta == 1) {
        _infoText = _possibleInfoTexts[2];
      } else {
        _people += delta;
        _infoText = _possibleInfoTexts[0];
      }
    });
  }

  // build: função sempre chamada quando queremos modificar algo no layout.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Image: onde serão postas informações para reproduzir a imagem.
        // BoxFit: configura omo uma caixa deve ser inscrita em outra caixa.
        Image.asset(
          "images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        // Column: widget que exibe seus children em uma matriz vertical.
        Column(
          // MainAxisAlignment: alinhamento do eixo principal.
          mainAxisAlignment: MainAxisAlignment.center,
          // <Widget>: É usado porque o children é uma lista de widgets.
          children: <Widget>[
            // Text: texto a ser exibido.
            Text(
              "Pessoas: $_people",
              style:
                  // TextStyle: classe que configura do estilo do texto.
                  // Colors: classe com a paleta de cores do Material Design.
                  // FontWeight: classe da espessura da fonte.
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // Row: widget que exibe seus filhos em uma matriz horizontal.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding: insere um padding no child.
                Padding(
                    // EdgeInsets: um conjunto imutável de deslocamentos em cada uma das quatro direções cardeais.
                    padding: EdgeInsets.all(10.0),
                    child:
                        // FlatButton: classe que define um botão.
                        FlatButton(
                      child: Text(
                        "+1",
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                      ),
                      onPressed: () {
                        _changePeople(1);
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                        "-1",
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                      ),
                      onPressed: () {
                        _changePeople(-1);
                      },
                    ))
              ],
            ),
            Text(
              "$_infoText",
              // FontStyle: classe da inclinação do texto.
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            )
          ],
        )
      ],
    );
  }
}
