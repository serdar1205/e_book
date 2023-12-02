import 'dart:io';

String reader(String name) =>
    File('test/fixtures/$name').readAsStringSync();