import 'dart:io';

String dataReader(String fileName) =>
    File('test/data_simulator/$fileName').readAsStringSync();
