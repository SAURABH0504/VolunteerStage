import 'package:volunteerstage/Model/Field.dart';
import 'package:volunteerstage/Model/Location.dart';

class NGO{
  String NGOId;
  String imageUrl;
  String name;
  List<Location> location;
  String description;
  List<Field> field;
  String password;

  NGO({this.password,this.NGOId,this.name, this.location, this.description, this.field,this.imageUrl});

  Map<String,dynamic> toMap(){
    return {
      'password':password,
      'imageUrl':imageUrl,
      'NGOId':NGOId,
      'name':name,
      'location':Location.ConvertCustomStepsToMap(location),
      'description':description,
      'field':Field.ConvertCustomStepsToMap(field)
    };
  }

  NGO.fromFirestore(Map<String,dynamic> firestore)
   : NGOId=firestore['NGOId'],
     password=firestore['password'],
     name=firestore['name'],
     imageUrl=firestore['imageUrl'],
     location = (firestore['location'] as List).map((e) => Location.fromFirestore(e.cast<String,dynamic>())).toList(),
     description=firestore['description'],
     field=(firestore['field'] as List).map((e) => Field.fromFirestore(e.cast<String,dynamic>())).toList();
}