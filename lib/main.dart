import 'package:flutter/material.dart';
import "chart.dart";

List<int> rolls = <int>[];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 40))))),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(rolls.toString()),
          title: const Text("Dice roll stats"),
        ),
        body: BarChartSample3(sharedRolls: rolls),
        bottomNavigationBar: NavigationBar(
          destinations: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: rolls.isEmpty ? null : () => {},
                onLongPress: rolls.isEmpty
                    ? null
                    : () => setState(() {
                          rolls.removeLast();
                        }),
                child: rolls.isEmpty
                    ? const Text(
                        "Undo last",
                        textScaleFactor: 2,
                      )
                    : Text("Undo last: ${rolls[rolls.length - 1]}",
                        textScaleFactor: 2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text(
                  "New roll: ${rolls.length}",
                  textScaleFactor: 2,
                ),
                onPressed: () => _showSimpleModalDialog(context),
                onLongPress: () => {},
              ),
            )
          ],
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  GridView Buttons() {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      children: GenButtons(),
      shrinkWrap: true,
    );
  }

  List<Widget> GenButtons() {
    var buttons = <ElevatedButton>[];

    for (int i = 2; i < 13; i++) {
      buttons.add(ElevatedButton(
          onPressed: () {
            setState(() {
              rolls.add(i);
            });
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          child: Text(
            i.toString(),
            textScaleFactor: 4,
          )));
    }

    return buttons;
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Buttons(),
            ),
          );
        });
  }
}
