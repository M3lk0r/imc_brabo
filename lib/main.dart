import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  void _redefinirCampos() {
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
      _resultado = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularImc() {
    setState(() {
      double valorPeso = double.parse(pesoController.text);
      double valorAltura = double.parse(alturaController.text);
      double imc = valorPeso / (valorAltura * valorAltura);

      if (imc < 18.6) {
        _resultado = "abaixo do peso";
      } else if (imc >= 18.6 && imc < 24.9) {
        _resultado = "Peso ideal (parabéns)";
      } else if (imc >= 24.9 && imc < 29.9) {
        _resultado = "Levemente acima do peso";
      } else if (imc >= 29.9 && imc < 34.9) {
        _resultado = "Obesidade grau I";
      } else if (imc >= 34.9 && imc < 39.9) {
        _resultado = "Obesidade grau II (severa)";
      } else if (imc >= 40) {
        _resultado = "Obesidade grau III (mórbida)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.refresh), onPressed: _redefinirCampos)
          ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(Icons.health_and_safety_outlined,
                    size: 120.0, color: Colors.black),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      helperText: "83.5",
                      labelText: "Informe seu peso",
                      prefix: Text("Quilos"),
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: pesoController,
                  //validator: (value) {
                  //  if (value.isEmpty) {
                  //    return "Insira valor do peso!";
                  //  }
                  //},
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      helperText: "1.93",
                      labelText: "Informe sua Altura",
                      prefix: Text("Metros"),
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: alturaController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _calcularImc();
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  _resultado,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 25),
                )
              ],
            ),
          )),
    );
  }
}
