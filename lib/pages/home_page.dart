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
  late int valueIncrementCounter = 0;
  TextEditingController textFieldController = TextEditingController();
  void incrementCounter() {
    setState(() {
      counter = counter + valueIncrementCounter;
    });
  }

  void restartCounter() {
    setState(() {
      counter = 0;
      valueIncrementCounter = 0;
      textFieldController.text = "";
    });
  }

  void setCounter(value) {
    if (value != "") {
      setState(() {
        valueIncrementCounter = int.parse(textFieldController.text);
      });
    } else {
      setState(() {
        valueIncrementCounter = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text('Aggiungi gli ITEM',
                style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Item inseriti: $counter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            child: TextField(
              controller: textFieldController,
              onChanged: (text) {
                setCounter(text);
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Quanti ITEM vuoi inserire ?',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton.icon(
                    onPressed: () => valueIncrementCounter != 0
                        ? incrementCounter()
                        : showAlertDialog(context),
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(valueIncrementCounter.toString()),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: OutlinedButton.icon(
                    onPressed: () => restartCounter(),
                    icon: const Icon(Icons.restart_alt_outlined),
                    label: const Text("Restart"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showAlertDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // <-- SEE HERE
        title: const Text('Attenzione'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Inserisci un numero maggiore di 0!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Chiudi'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
