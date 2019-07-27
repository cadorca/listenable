import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:listenable/listenable.dart';
import 'package:source_gen/source_gen.dart';

import 'utils.dart';

class ListenableGenerator extends GeneratorForAnnotation<ListenableModel> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    ClassElement clazz = element;

    final _listenableModelChecker = TypeChecker.fromRuntime(ListenableModel);

    final fieldsToProcess =
        clazz.fields.where((f) => _listenableModelChecker.hasAnnotationOfExact(f));

    return """
    
    mixin ${_getInternalStreamName(clazz)} on ${clazz.name} {
    
    // Stream fields
    ${_genStreamsFieldForFields(fieldsToProcess)}
    
    // Main stream
    final StreamController<${_getGeneratedStreamClassName(clazz)}> ${_getStreamControllerName(clazz)} = StreamController.broadcast();
   
    // Getters and Setter for fields
    ${_genFieldsGetterSetters(fieldsToProcess)}
    
    // Stream exposure
    ${_genGetFieldStreams(fieldsToProcess)}
    Stream<${_getGeneratedStreamClassName(clazz)}> get stream => ${_getStreamControllerName(clazz)}.stream;

     void notifyListeners(){
        ${_getStreamControllerName(clazz)}.sink.add(this);
     }

    // Dispose
    ${_genStreamsDisposal(clazz, fieldsToProcess)}
  
    }  
   
    """;
  }

  String _genStreamsFieldForFields(Iterable<FieldElement> fields) {
    return fields.map((f) => """
      final StreamController<${f.type.displayName}> ${_getStreamControllerName(f)} = StreamController.broadcast();
  
    """).join("\n");
  }

  String _genGetFieldStreams(Iterable<FieldElement> fields) {
    return fields
        .map((f) =>
            """Stream<${_genType(f)}> get ${f.name.replaceFirst("_", "")}Stream => ${_getStreamControllerName(f)}.stream;""")
        .join("\n");
  }

  String _genFieldsGetterSetters(Iterable<FieldElement> fields) {
    return fields
        .map((f) => _genFieldGetter(f) + _genFieldSetter(f))
        .join("\n");
  }

  String _genFieldGetter(FieldElement f) {
    if (f.isPrivate) {
      return _genPrivateFieldGetter(f);
    } else {
      return "";
    }
  }

  String _genPrivateFieldGetter(FieldElement f) {
    return """${f.type.name} get ${publicName(f)} => ${f.name};  """;
  }

  String _genFieldSetter(FieldElement f) {
    if (f.isPrivate) {
      return _genPrivateFieldSetter(f);
    } else {
      return _genPublicFieldSetter(f);
    }
  }

  String _genPrivateFieldSetter(FieldElement f) {
    return """
      set ${publicName(f)}(\$newValue) {
       if(${f.name} != \$newValue){
         ${_genPrivateFieldSetterSuperCall(f)}
         ${_getStreamControllerName(f)}.sink.add(\$newValue);
         ${_getStreamControllerName(f.enclosingElement)}.sink.add(this);
       }
      } 
    """;
  }

  String _genPrivateFieldSetterSuperCall(FieldElement f) {
    final ClassElement clazz = f.enclosingElement;
    final fieldPublicSetterName = publicName(f);
    if (clazz.accessors
        .where((a) => a.isSetter && a.displayName == fieldPublicSetterName)
        .isEmpty) {
      return "super.${f.name} = \$newValue;";
    } else {
      return "super.${fieldPublicSetterName} = \$newValue;";
    }
  }

  String _genPublicFieldSetter(FieldElement f) {
    return """
      set ${publicName(f)}(\$newValue) {
       if(${f.name} != \$newValue){
         super.${f.name} = \$newValue;
         ${_getStreamControllerName(f)}.sink.add(\$newValue);
         ${_getStreamControllerName(f.enclosingElement)}.sink.add(this);
       }
      } 
    """;
  }

  String _getGeneratedStreamClassName(Element e) => "${publicName(e)}";

  String _getInternalStreamName(Element e) => "_${publicName(e)}\$Stream";

  String _getStreamControllerName(Element e) =>
      "_${publicName(e)}StreamController";

  _genStreamsDisposal(ClassElement clazz, Iterable<FieldElement> fields) {
    return """
    void dispose() {
      ${fields.map((f) => "${_getStreamControllerName(f)}.close();").join("\n")}
      ${_getStreamControllerName(clazz)}.close();
    }  
    """;
  }

  String _genType(FieldElement e) {
    return e.type.displayName;
  }
}
