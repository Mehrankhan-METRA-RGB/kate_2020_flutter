

import 'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';
class DropDown extends StatefulWidget {
  DropDown({this.onChange,this.values,this.hint,this.value});
  final ValueChanged? onChange;
  final List? values;
  final String? hint;
  final Object? value;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  Object _value='1';
  // List values=['1','2','3','4'];
  List<DropdownMenuItem<Object>>? list;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: Card(elevation: 10,shadowColor: Colors.black,color:    AppColors.card,clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: DropdownButton(

            isExpanded: true,
            iconSize: 25,
            elevation:9,
            // icon: Icon(Icons.font_download),
            hint:  Text(widget.hint!),
            dropdownColor: Colors.white,
            value: widget.value,
            items:list,
            onChanged: (value) {
              setState(() {});
var callback=widget.onChange;
if(callback!=null){
  callback(value);
}


            },
          ),
        ),
      ),
    );
  }

 List<DropdownMenuItem<Object>>? dropDown(){
    // for(var a=0;a<=widget.values!.length-1;a++){
    //   return  DropdownMenuItem(
    //     child: Text(widget.values![a],),
    //     value: widget.values![a],
    //   );
    // }



    return list;

  }
}
