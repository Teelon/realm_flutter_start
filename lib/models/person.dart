import 'package:realm/realm.dart';

part 'person.g.dart';

@RealmModel()
class $Person {
  late String name;
  int age = 1;
}
