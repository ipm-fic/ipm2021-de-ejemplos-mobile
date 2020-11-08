import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (_) => CounterCubit(),
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
              onPressed: () { context.bloc<CounterCubit>().decrement(); },
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (BuildContext context, state) => Text(
                '${state}',
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
              onPressed: () { context.bloc<CounterCubit>().increment(); },
            ),
          ],
        ),
      ),
    );
  }
  
}



class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  /// Add 1 to the current state.
  void increment() { emit(state + 1); }

  /// Subtract 1 from the current state.
  void decrement() { emit(state - 1); }
}


