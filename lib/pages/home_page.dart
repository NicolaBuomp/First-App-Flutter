import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.valueCounter});

  final String title;
  final int valueCounter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int counter = widget.valueCounter;
  late int valueIncrementCounter;

  void incrementCounter() {
    setState(() {
      counter = counter + valueIncrementCounter;
    });
  }

  void restartCounter() {
    setState(() {
      counter = 0;
      valueIncrementCounter = 0;
    });
  }

  void setCounter(value) {
    setState(() {
      valueIncrementCounter = int.parse(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Text('You have pushed the button this many times:',
              style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
          Text(
            '$counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            child: TextField(
              onChanged: (text) {
                setCounter(text);
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton.icon(
                  onPressed: () => incrementCounter(),
                  icon: Icon(Icons.add, size: 18),
                  label: Text("Aggiungi"),
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: OutlinedButton.icon(
                  onPressed: () => restartCounter(),
                  icon: Icon(Icons.restart_alt_outlined),
                  label: Text("Restart"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
