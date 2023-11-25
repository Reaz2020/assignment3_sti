import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';



@immutable
class Clique {

  
  final String id; // TODO: generate with uuid?
  final String name; // creator selects name of clique

  

  /*Clique({
    required this.id,
    required this.name,
  });*/

  Clique({String? id, required this.name})
      : id = id ?? Uuid().v4();// me
}
