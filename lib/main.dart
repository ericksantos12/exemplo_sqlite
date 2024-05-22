import 'package:exemplo_sqflite/database_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MaterialApp(
        title: "SQFlite Demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatelessWidget {

  final dbHelper = DatabaseHelper.instance;
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de CRUD básico')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Inserir dados', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _inserir();
              },
            ),
            ElevatedButton(
              child: const Text('Consultar dados', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _consultar();
              },
            ),
            ElevatedButton(onPressed: () {
              _atualizar();
            }, child: const Text('Atualizar dados', style: TextStyle(fontSize: 20))),
            ElevatedButton(onPressed: () {_deletar();}, child: const Text('Deletar dados', style: TextStyle(fontSize: 20)))
          ],
        ),
      )
    );
  }

  void _inserir() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnNome: 'Wilson',
      DatabaseHelper.columnIdade: 50
    };

    final id = await dbHelper.insert(row);

    print('Linha inserida id: $id');
  }

  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas:');
    for (var row in todasLinhas) {
      print(row);
    }
  }

  void _atualizar() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnNome: 'Maria',
      DatabaseHelper.columnIdade: 32
    };

    final linhasAfetadas = await dbHelper.update(row);
    print('Atualizadas $linhasAfetadas linha(s)');
  }

  void _deletar() async {
    final id = await dbHelper.queryRowCount();
    final linhaDeletada = await dbHelper.delete(id!);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
  }
}
