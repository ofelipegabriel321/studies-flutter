// import necessário para o runApp(app)
import 'package:flutter/material.dart';

void main() {
  runApp(
      // MaterialApp: widget necessário para que o App suporte widgets do Material Design.
      MaterialApp(
          title: "Contador de pessoas",
          // Column: widget que exibe seus children em uma matriz vertical.
          home: Column(
            // MainAxisAlignment: alinhamento do eixo principal.
            mainAxisAlignment: MainAxisAlignment.center,
            // <Widget>: É usado porque o children é uma lista de widgets.
            children: <Widget>[
              // Text: texto a ser exibido.
              Text(
                "Pessoas: 0",
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
                  // FlatButton: classe que define um botão
                  FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Text(
                "Pode Entrar!",
                // FontStyle: classe da inclinação do texto.
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0),
              )
            ],
          )));
}
