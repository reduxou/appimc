import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController alturaEntrada = TextEditingController();
  TextEditingController pesoEntrada = TextEditingController();
  String resultado = 'Informe seus dados.';

  void _resetFields() {
    pesoEntrada.text = '';
    alturaEntrada.text = '';
    setState(() {
      resultado = "Informe seus dados.";
    });
  }

  void calcular() {
    setState(() {
      double peso = double.parse(pesoEntrada.text);
      double altura = double.parse(alturaEntrada.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.6) {
        resultado = "Abaixo do peso: ${imc.toStringAsFixed(1)}";
      } else if (imc < 25.0) {
        resultado = "Peso ideal: ${imc.toStringAsFixed(1)}";
      } else if (imc < 30.0) {
        resultado = "Levemente acima do peso: ${imc.toStringAsFixed(1)}";
      } else if (imc < 35.0) {
        resultado = "Obesidade Grau I: ${imc.toStringAsFixed(1)}";
      } else if (imc < 40.0) {
        resultado = "Obesidade Grau II: ${imc.toStringAsFixed(1)}";
      } else {
        resultado = "Obesidade Grau IIII: ${imc.toStringAsFixed(1)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Calculadora de IMC'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('images/user.png'),
                                fit: BoxFit.scaleDown))),
                    SizedBox(height: 60),
                    TextFormField(
                        controller: alturaEntrada,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 3.0)),
                          labelText: 'Altura (cm)',
                          labelStyle: TextStyle(color: Colors.green),
                          enabledBorder: UnderlineInputBorder(),
                        ),
                        validator: (value) => value.isEmpty
                            ? 'O campo email não pode ficar vazio.'
                            : null),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: pesoEntrada,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 3.0)),
                            labelText: 'Peso (kg)',
                            labelStyle: TextStyle(color: Colors.green),
                            enabledBorder: UnderlineInputBorder()),
                        validator: (value) => value.isEmpty
                            ? 'O campo senha não pode ficar vazio.'
                            : null),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.2, 1],
                                colors: [Colors.green, Colors.green]),
                            borderRadius: BorderRadius.circular(3)),
                        child: SizedBox.expand(
                            child: FlatButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    calcular();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CALCULAR',
                                      style: TextStyle(fontSize: 19),
                                    )
                                  ],
                                )))),
                    SizedBox(height: 20),
                    Text(
                      resultado,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.green),
                    )
                  ],
                ))));
  }
}
