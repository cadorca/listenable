import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/change_notifier_generator.dart';

Builder listenableBuilder(BuilderOptions options) =>
    SharedPartBuilder([ListenerGenerator()], 'listenable');