import 'package:analyzer/dart/element/element.dart';

String publicName(Element field){
  if(field.isPublic){
    return field.name;
  } else {
    return field.name.replaceFirst("_", "");
  }
}