import 'package:flutter/material.dart';

main() {
	runApp(
			MaterialApp(
				home: Home(),
			)
	);
}

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	var _infoText = "Informe seus dados!!";

	TextEditingController weightController = TextEditingController();
	TextEditingController heightController = TextEditingController();

	GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	_resetFields() {
		weightController.text = '';
		heightController.text = '';

		setState(() {
			_infoText = "Informe seus dados!!";
			_formKey = GlobalKey<FormState>();
		});
	}

	_calcImc() {
		setState(() {
			var weight = double.parse(weightController.text);
			var height = double.parse(heightController.text) / 100;
			var imc = weight / (height * 2);

			if (imc < 18.6) {
				_infoText = "Abaixo do peso! ${imc.toStringAsPrecision(3)}";
			} else if (imc > 18.5 && imc < 24.9) {
				_infoText = "Peso normal ${imc.toStringAsPrecision(3)}";
			} else if (imc > 25 && imc < 29.9) {
				_infoText = "Sobrepeso ${imc.toStringAsPrecision(3)}";
			} else if (imc > 30 && imc < 34.9) {
				_infoText = "Obesidade grau 1 ${imc.toStringAsPrecision(3)}";
			} else if (imc > 35 && imc < 39.9) {
				_infoText = "Obesidade grau 2 ${imc.toStringAsPrecision(3)}";
			} else {
				_infoText = "Obesidade grau 3 ${imc.toStringAsPrecision(3)}";
			}
		});
	}


	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Calculadora de IMC'),
				centerTitle: true,
				backgroundColor: Colors.purple,
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.refresh),
						onPressed: _resetFields,
					)
				],
			),
			backgroundColor: Colors.purple[100],
			body: SingleChildScrollView(
					padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
					child: Form(
						key: _formKey,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: <Widget>[
								Icon(Icons.person_outline, size: 160, color: Colors.purple[700]),
								TextFormField(
									keyboardType: TextInputType.number,
									decoration: InputDecoration(
											labelText: "Peso (kg)",
											labelStyle: TextStyle(color: Colors.purple)
									),
									textAlign: TextAlign.center,
									style: TextStyle(color: Colors.purple, fontSize: 25),
									controller: weightController,
									validator: (val) {
										if (val.isEmpty) {
											return "Insira seu peso";
										}
									},
								),
								TextFormField(
										keyboardType: TextInputType.number,
										decoration: InputDecoration(
												labelText: "Altura (cm)",
												labelStyle: TextStyle(color: Colors.purple)
										),
										textAlign: TextAlign.center,
										style: TextStyle(color: Colors.purple, fontSize: 25),
										controller: heightController,
										validator: (val) {
											if (val.isEmpty) {
												return "Insira seu peso";
											}
										}
								),
								Padding(
									padding: EdgeInsets.only(top: 20, bottom: 20),
									child: Container(
										height: 50,
										child: RaisedButton(
											onPressed: () {
												if(_formKey.currentState.validate()) {
													_calcImc();
												}
											},
											child: Text("Calcular",
													style: TextStyle(fontSize: 25, color: Colors.white
													)),
											color: Colors.purple,
										),
									),
								),
								Text(_infoText,
									textAlign: TextAlign.center,
									style: TextStyle(color: Colors.purple, fontSize: 25),
								)
							],
						),
					)
			),
		);
	}
}
