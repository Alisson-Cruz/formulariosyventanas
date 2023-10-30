import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> dataEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Captura de Datos'),
      ),
      body: ListView.builder(
        itemCount: dataEntries.length,
        itemBuilder: (context, index) {
          return DataCard(data: dataEntries[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return DataCaptureForm(
                onDataSaved: (data) {
                  setState(() {
                    dataEntries.add(data);
                  });
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DataCaptureForm extends StatefulWidget {
  final Function(String) onDataSaved;

  DataCaptureForm({required this.onDataSaved});

  @override
  _DataCaptureFormState createState() => _DataCaptureFormState();
}

class _DataCaptureFormState extends State<DataCaptureForm> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Ingrese un dato'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String data = textController.text;
              widget.onDataSaved(data);
              Navigator.of(context).pop();
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  final String data;

  DataCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(data),
      ),
    );
  }
}