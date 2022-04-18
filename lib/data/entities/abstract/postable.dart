import 'dart:io';

abstract class Postable{
  Map<String, dynamic> toJson();
  Map<String, File> getFiles();

}