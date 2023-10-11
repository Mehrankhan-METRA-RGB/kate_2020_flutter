import 'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/widgets/read_more_text.dart';
class AppCard extends StatelessWidget {
  AppCard({required this.heading,this.data,this.width});
  final String? heading;
  final Widget? data;
  // final double? height;
  final double? width;

  var _height,_width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return


      Container(width:width,child:
    Card(elevation: 1,shadowColor: Colors.black,
      color: AppColors.card,
      clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
              decoration:  BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,

              colors: [
                AppColors.gradient[0],
                AppColors.gradient[1],
                // Colors.red,
              ],
            )),
              child: Row(
                children: [
                  Text(heading!,style: const TextStyle(color: AppColors.text,fontSize: 20),),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            Container(padding:const EdgeInsets.all(10),
              child: data!,
            ),
            Divider(height: 16,color: AppColors.gradient[1],),
          ],
        ),

    ),);
  }
}
