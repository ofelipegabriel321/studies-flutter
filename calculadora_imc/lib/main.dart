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
  String _infoText = "Informe seus dados!";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // GlobalKey: uma chave que é única em todo o aplicativo.
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    // Para remover a mensagem de erro ao resetar:
    _formKey = GlobalKey<FormState>();
    // Como o weightController e o heightController são controllers, não precisamos dar o setState.
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      String imcOutput = imc.toStringAsPrecision(3);

      if (imc < 18.5) {
        _infoText = "Abaixo do peso ($imcOutput)";
      } else if (imc < 25) {
        _infoText = "Peso ideal ($imcOutput)";
      } else if (imc < 30) {
        _infoText = "Levemente acima do peso ($imcOutput)";
      } else if (imc < 35) {
        _infoText = "Obesidade grau I ($imcOutput)";
      } else if (imc < 40) {
        _infoText = "Obesidade grau II ($imcOutput)";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau III ($imcOutput)";
      }
    });
  }

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
              onPressed: _resetFields,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        //   SingleChildScrollView: garante que o container de um filho seja rolável quando a
        // tela estiver muito pequena para ele (na direção da rolagem).
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            // Form:
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  // [CHANGED] TextField: campo de texto do material design.
                  // TextFormField: campo de texto de um formulário do material design.
                  TextFormField(
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
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "insira sua Altura!";
                      }
                    },
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
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
