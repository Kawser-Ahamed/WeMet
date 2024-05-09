import 'package:flutter/material.dart';
import 'package:wemet/core/reusable/loading.dart';

authLoading(BuildContext context){
  return showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context) {
      return const Loading(color: Colors.white, size: 0.1);
    },
  );
}