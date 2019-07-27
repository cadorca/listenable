import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'package:listenable/listenable.dart';
import 'listeable_class.dart';

class ListenerGenerator extends GeneratorForAnnotation<ListenableModel> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {

    final listenableClass = ListenableClass(element);
    return listenableClass.generatedCode;
  }
}