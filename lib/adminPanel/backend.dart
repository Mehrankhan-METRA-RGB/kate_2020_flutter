import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Connect {
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future delete(id, {table = 'blog'}) async {
    String url = '${AppUrl.temp}delete/$table/$id';
    var res = await http.get(
      Uri.parse(url),
    );
    print(res.statusCode);
    return res.statusCode;
  }

  static Future update({required data}) async {
    String url = '${AppUrl.temp}update/data';
    // data.jsondecode();
    var res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    return res.statusCode;
  }

  static appAlert(context, {title, required Widget content, okPressed}) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.card,
            title: Text(title.toString()),
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: content,
            actions: [
              MaterialButton(
                onPressed: okPressed,
                child: Text(
                  'OK',
                  style: TextStyle(color: AppColors.gradient[0]),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.gradient[0]),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  static appDialog(context, {content, title, scroll = true}) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Row(
              children: [
                Text(title, style: const TextStyle(fontSize: 20)),
                Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close_rounded))
              ],
            ),
            backgroundColor: AppColors.card,
            scrollable: scroll,
            insetPadding: EdgeInsets.zero,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: content,
          );
        });
      },
    );
  }

  static whatsApp({String? phone, String? text}) async {
    var link = WhatsAppUnilink(
      phoneNumber: phone!,
      text: '''$text''',
    );
    await launch('$link');
  }

  static mail({String? email, String? text}) async {
    Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': ''' 
        $text
        
         (kateintl.com)'''
      }),
    );
    await launch(emailLaunchUri.toString());
  }

  static toast(
      {msg,
      Color bColor = AppColors.primary,
      Color tColor = AppColors.text,
      size = 18}) {
    return Fluttertoast.showToast(
        webPosition: 'bottom',
        timeInSecForIosWeb: 6,
        msg: msg,
        backgroundColor: bColor,
        fontSize: size,
         gravity: ToastGravity.SNACKBAR,
        textColor: tColor);
  }

  static snackBar(context,
      {required Widget msg, background = AppColors.primary}) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: background, content: msg));
  }

  static completionDate(date,{duration=30}) {
    var ldate=date.toString().replaceAll('-', '');
    var initDate = DateTime.parse("$ldate");
    var completionDate = initDate.add(Duration(days: duration));
    return completionDate.toString().substring(0, 10).replaceAll('-', '');
  }
  static verification(nic,date) {
    ///verification code:  concat nic + completion date  divide by completion date and then  divide by 1.8
   var ldate=date.toString().replaceAll('-', '');
    var verify = int.parse('$nic$ldate') / int.parse(ldate.toString());
    var generate = (verify / 2);
    var vlength=generate.round().toString().length;
    var first=generate.round().toString().substring(0,5);
    var second=Random().nextInt(999).toString();
    if(vlength>9){
      second=generate.round().toString().substring(5,8);
    }
    var third='0000';
    if(vlength>12){
      third=generate.round().toString().substring(8,11);
    }
    var full='$first-$second-$third';
    return full;
  }
  static  registrationNo(nic,date) {
    var ldate=date.toString().replaceAll('-', '');
    var no = nic!.length;
    return 'kate-${nic!.substring(no - 5, no - 1)}-${completionDate(ldate).toString().substring(0, 7)}';
  }
}
