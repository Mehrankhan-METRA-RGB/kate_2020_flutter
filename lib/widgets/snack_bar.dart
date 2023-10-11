import 'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';
class AppSnackBar{
  AppSnackBar({this.content});
  final String? content;

  snackBar(BuildContext context ){
   return ScaffoldMessenger.of(context)
        .showSnackBar(
         SnackBar(
          backgroundColor:AppColors.primary,
          content: Text(
            content!,

            style: const TextStyle(color:AppColors.text ),
          ),
        )

    );
  }
}
