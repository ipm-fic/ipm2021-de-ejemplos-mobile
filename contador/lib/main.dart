import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      model: CounterModel(),
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
    final counter = CounterProvider.of(context);
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
              onPressed: counter.model.decrement,
            ),
            // ¿ Cómo lo convierto en observador ?
            Text(
              '${counter.model.currentCount}',
              style: Theme.of(context).textTheme.headline4, 
            ),
            FlatButton(
              child: Text("+1",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
              onPressed: counter.model.increment,
            ),
          ],
        ),
      ),
    );
  }
  
}



class CounterProvider extends InheritedWidget {
  final CounterModel model;

  CounterProvider({this.model, Widget child}) : super(child: child);

  static CounterProvider of(BuildContext context) =>
    context.inheritFromWidgetOfExactType(CounterProvider);
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true; 
}



class CounterModel {
  // ¿ Cómo lo convierto en observable ?
  int _counter = 0;

  void increment() {
    _counter++;
    // ¿ Cómo notifico a los observadores ?
  }

  void decrement() {
    _counter--;
    // ¿ Cómo notifico a los observadores ?
  }

  int get currentCount => _counter;
}
