import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterPage(title: 'Contador simple'),
    );
  }
}

class CounterPage extends StatefulWidget {
  CounterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _increment() {
    setState(() { _counter++; });
  }

  void _decrement() {
    setState(() { _counter--; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              child: Text("-1",
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
              onPressed: _decrement,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4, 
            ),
            FlatButton(
              child: Text("+1",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
              onPressed: _increment,
            ),
          ],
        ),
      ),
    );
  }
  
}
