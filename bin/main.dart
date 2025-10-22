import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('use: dart run bin/main.dart <feature_name>');
    exit(1);
  }

  final featureName = args.first.toLowerCase(); // ex: on_boarding
  final featurePath = 'lib/features/$featureName';

  final className = _snakeToPascal(featureName);

  final folders = [
    '$featurePath/presentation/view',
    '$featurePath/model',
    '$featurePath/repo',
    '$featurePath/cubit',
  ];

  for (var folder in folders) {
    Directory(folder).createSync(recursive: true);
  }

  // View file
  final viewFile = File('$featurePath/presentation/view/${featureName}_view.dart');
  viewFile.writeAsStringSync('''
import 'package:flutter/material.dart';

class ${className}View extends StatelessWidget {
  const ${className}View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("$className View"),
      ),
    );
  }
}
''');

  // Repo file
  final repoFile = File('$featurePath/repo/${featureName}_repo.dart');
  repoFile.writeAsStringSync('''
class ${className}Repo {
  // TODO: implement repo methods
}
''');

  // Model file
  final modelFile = File('$featurePath/model/${featureName}_model.dart');
  modelFile.writeAsStringSync('''
class ${className}Model {
  // TODO: define model fields
}
''');

  // Cubit + State
  final cubitFile = File('$featurePath/cubit/${featureName}_cubit.dart');
  cubitFile.writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';

part '${featureName}_state.dart';

class ${className}Cubit extends Cubit<${className}State> {
  ${className}Cubit() : super(${className}Initial());
}
''');

  final stateFile = File('$featurePath/cubit/${featureName}_state.dart');
  stateFile.writeAsStringSync('''
part of '${featureName}_cubit.dart';

abstract class ${className}State {}

class ${className}Initial extends ${className}State {}
''');

  print(" Feature '$featureName' created successfully as $className!");
  print(' Path: ${viewFile.path}');
}

String _snakeToPascal(String text) {
  return text.split('_').map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1);
  }).join();
}
