// import necessário para o runApp(app)
import 'package:flutter/material.dart';

void main(){
  runApp(
    // MaterialApp: widget necessário para que o App suporte widgets do Material Design.
    MaterialApp(
      title: "Contador de pessoas",
      // Container: combina widgets comuns de painting, positioning e sizing.
      home: Container(color: Colors.white,),
    )
  );
}