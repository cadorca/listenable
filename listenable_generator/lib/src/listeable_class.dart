import 'package:analyzer/dart/element/element.dart';
import 'package:listenable/listenable.dart';
import 'package:source_gen/source_gen.dart';

import 'listenable_field.dart';
import 'utils.dart';

class ListenableClass {

  final ClassElement clazz;
  List<ListenableField> fields;

  ListenableClass(this.clazz) {
    final _listenablePropertyChecker = TypeChecker.fromRuntime(ListenableProperty);
    fields = clazz.fields
        .where((f) => _listenablePropertyChecker.hasAnnotationOfExact(f))
        .where((f) => !f.isFinal)
        .map((f) => ListenableField(f, this))
        .toList();
  }

  String get name => "_${publicName(clazz)}\$Listenable";

  String get sourceName => clazz.name;

  String get sourcePublicName => publicName(clazz);

  String get sourceFieldType => clazz.type.displayName;

  String get propertyManagerClassName =>
      "_${sourcePublicName}ChangeProperty";

  String get propertyManagerClass {
    return """
    class ${propertyManagerClassName}<T> extends ChangeNotifier implements ValueListenable<T> {
      final T Function() valueAccessor;
      ${propertyManagerClassName}(this.valueAccessor);
      @override
      T get value => valueAccessor();
      @override void notifyListeners() { super.notifyListeners(); }
    }
    """;
  }

  String get generatedCode => """
    mixin $name on $sourceName {
    
      // Fields
      ${fields.map((f) => f.generatedCode).join("\n")}
      
      $propertyManagerClassName<$sourcePublicName> _changeNotifier;
      
      ValueListenable<$sourcePublicName> get listenable {
        if(_changeNotifier == null){
          _changeNotifier = $propertyManagerClassName<$sourcePublicName>(() => this);
        }
        return _changeNotifier;
      }    

      
      void dispose(){
        ${fields.map((f) => f.disposeMethodCall).join("\n")}
        if(_changeNotifier != null) _changeNotifier.dispose();
      }
      
      void notifyListeners(){
      
      }
    }
      
    $propertyManagerClass    
  """;
}