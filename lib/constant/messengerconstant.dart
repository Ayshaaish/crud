import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showUploadMessage(String text, BuildContext context,){
return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}