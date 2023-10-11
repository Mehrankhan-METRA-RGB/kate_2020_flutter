import'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';



class TheTextField extends StatelessWidget {
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextStyle? style;
  final TextEditingController? controller;
  TheTextField({
    this.controller,
     this.hintText,
     this.style,
    this.onChange,
    this.validator,});
  var nm='Enter';
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: Card(elevation: 10,shadowColor: Colors.black,color:    AppColors.card,clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Center(
          child: TextFormField(
controller: controller,
                validator: ( value) {
                  if (value == null || value.isEmpty) {
                    callback(value);
                    return 'Please enter some data into field';
                  }
                  else
                  {
                    callback(value);
                      return  callback(value);

                  }

                },
                onChanged: (a) {
                  callback(a);
                } ,
                decoration: InputDecoration(
                  // alignLabelWithHint: true,
                    border: InputBorder.none,

                    hintStyle:  const TextStyle(color:Colors.black54),
                  filled: true,
                    hintText: '$nm ${hintText}...',
                    labelText: hintText,


                    hoverColor:const Color(0xBAD2D1CF),
                    focusColor: AppColors.primary,
                    fillColor: const Color(0xE6EFEFEF), ),
              ),
        ),


      ),
    );
  }
  callback(a){
    var callback = onChange;
    if (callback != null) {
      callback(a);
    }
  }
}
