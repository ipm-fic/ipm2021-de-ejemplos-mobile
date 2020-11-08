import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BLoC(
      state: CounterModel(),
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
    final bloc = BLoC.of(context);
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
              onPressed: () { bloc.inCounterEvent.add(CounterEvent.decrement); },
            ),
            StreamBuilder(
              stream: bloc.outCounter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) => Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.headline4, 
              ),
            ),
            FlatButton(
              child: Text("+1",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
              onPressed: () { bloc.inCounterEvent.add(CounterEvent.increment); },
            ),
          ],
        ),
      ),
    );
  }
  
}



class BLoC extends InheritedWidget {
  final BLoCData blocData;

  BLoC({state, Widget child}) : this.blocData = BLoCData(state), super(child: child);

  
  static BLoCData of(BuildContext context) {
    BLoC bloc = context.inheritFromWidgetOfExactType(BLoC) as BLoC;
    return bloc.blocData;
  }
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class BLoCData {
  final CounterModel _counter;
  StreamController<CounterEvent> _inCounterEvent = StreamController<CounterEvent>();
  StreamController<int> _outCounter = StreamController<int>();
  
  BLoCData(this._counter) {
    _inCounterEvent.stream.listen(this.mapEvent);
    _outCounter.add(_counter.currentCount);
  }

  StreamController<CounterEvent> get inCounterEvent => _inCounterEvent;
  Stream<int> get outCounter => _outCounter.stream;

  void mapEvent(CounterEvent event) {
    switch (event) {
      case CounterEvent.increment:
        _counter.increment();
        _outCounter.add(_counter.currentCount);
        break;
      case CounterEvent.decrement:
        _counter.decrement();
        _outCounter.add(_counter.currentCount);
        break;
    }
  }
}

enum CounterEvent { increment, decrement }

class CounterModel {
  int _counter = 0;

  void increment() {
    _counter++;
  }

  void decrement() {
    _counter--;
  }

  int get currentCount => _counter;
}
