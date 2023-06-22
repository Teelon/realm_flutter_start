// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'models/car.dart';
import 'models/person.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Realm _realm;

  _MyAppState() {
    final config = Configuration.local([Car.schema, Person.schema]);
    _realm = Realm(config);
  }

  int get carsCount => _realm.all<Car>().length;

  @override
  void initState() {
    var myCar = Car(ObjectId(), "Tesla", model: "Model Y", kilometers: 1);
    _realm.write(() {
      print('Adding a Car to Realm.');
      var car = _realm.add(Car(ObjectId(), "Tesla", owner: Person("John")));
      print("Updating the car's model and kilometers");
      car.model = "Model 3";
      car.kilometers = 5000;

      print('Adding another Car to Realm.');
      _realm.add(myCar);

      print("Changing the owner of the car.");
      myCar.owner = Person("me", age: 18);
      print("The car has a new owner ${car.owner!.name}");
    });

    print("Getting all cars from the Realm.");
    var cars = _realm.all<Car>();
    print("There are ${cars.length} cars in the Realm.");

    var indexedCar = cars[0];
    print('The first car is ${indexedCar.make} ${indexedCar.model}');

    print("Getting all Tesla cars from the Realm.");
    var filteredCars = _realm.all<Car>().query("make == 'Tesla'");
    print('Found ${filteredCars.length} Tesla cars');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("THis Is car COunt"),
      ),
      body: Center(
        child: Text('.\nThere are $carsCount cars in the Realm.\n'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _realm.close();
    super.dispose();
  }
}
