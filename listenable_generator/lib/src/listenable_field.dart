import 'package:analyzer/dart/element/element.dart';
import 'package:listenable/listenable.dart';
import 'package:source_gen/source_gen.dart';

import 'listeable_class.dart';
import 'utils.dart';

class ListenableField {
  final ListenableClass clazz;
  final FieldElement f;
  bool updatesModel;
  bool alwaysFireChangeEvent;

  ListenableField(this.f, this.clazz) {
    final _listenablePropertyChecker =
        TypeChecker.fromRuntime(ListenableProperty);
    updatesModel = _listenablePropertyChecker
        .firstAnnotationOf(f)
        .getField('updatesModel')
        .toBoolValue();
    alwaysFireChangeEvent = _listenablePropertyChecker
        .firstAnnotationOf(f)
        .getField('alwaysFireChangeEvent')
        .toBoolValue();
  }

  String get sourceName => f.name;

  String get sourcePublicFieldName => publicName(f);

  String get sourceFieldType => f.type.displayName;

  String get name => "_${sourceName}PropertyNotifier";

  String get type => "${clazz.propertyManagerClassName}<$sourceFieldType>";

  String get listenablePropertyGetterMethodName =>
      "${sourcePublicFieldName}Listenable";

  String get listenablePropertyGetterMethod => """
     ValueListenable<${f.type.displayName}> get ${listenablePropertyGetterMethodName} {
      if($name == null){
        $name = ${clazz.propertyManagerClassName}(() => super.${sourceName});
      }
      return $name;
     }    
    """;

  String get setterMethod => """
      set ${sourceName}(\$newValue) {
        ${alwaysFireChangeEvent ? setterMethodBody : "if(${f.name} != \$newValue){$setterMethodBody}" }
      } 
    """;

  String get setterMethodBody => """
         super.${f.name} = \$newValue;
         // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
         if($name != null){
          $name.notifyListeners();
         }
         
         if(_changeNotifier != null){
           ${updatesModel ? """
           // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
           _changeNotifier.notifyListeners();
            """ : ''}  
         } 
  """;

  String get disposeMethodCall => "if(${name} != null) ${name}.dispose();";

  String get generatedCode => """
    $type $name;
    
    $setterMethod
    $listenablePropertyGetterMethod
  """;
}
