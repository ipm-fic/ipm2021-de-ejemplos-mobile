import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MaterialApp(
        title: 'Contador',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CounterPage(title: 'Contador simple'),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  CounterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context, listen: false);
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
              onPressed: counter.decrement,
            ),
            Consumer<CounterModel>(
              builder: (context, counter, child) => Text(
                '${counter.currentCount}',
                style: Theme.of(context).textTheme.headline4, 
              )
            ),
            FlatButton(
              child: Text("+1",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
              onPressed: counter.increment,
            ),
          ],
        ),
      ),
    );
  }
  
}



// ChangeNotifier equivale a un Obervable 
class CounterModel with ChangeNotifier {
  int _counter = 0;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }

  int get currentCount => _counter;
}
