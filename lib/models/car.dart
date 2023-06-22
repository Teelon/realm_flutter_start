import 'package:realm/realm.dart';
import './person.dart';

part 'car.g.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late ObjectId id;

  late String make;
  String? model;
  int? kilometers = 500;
  late $Person? owner;
}
