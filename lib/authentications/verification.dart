import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/textfield.dart';
class Verification extends StatefulWidget {
  Verification({this.width});
  final double? width;
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController _verifyCodeController = TextEditingController();
  var _verifyCode;
  final _verifyForm = GlobalKey<FormState>();
  Future verification(code) async {
    Response response;
    var dio = Dio();
    response = await dio.get(
      "${AppUrl.temp}verification/$code",
    );
    // // print(response.data.toString());
    Map<String, dynamic> diodata = {
      'statusCode': response.statusCode,
      'body': response.data,
    };
    var data = jsonEncode(diodata);
    return response.data;
  }

  var _width, _height,_valueSize,_headingSize;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _headingSize=_width>=500?15:13;
    _valueSize=_width>=500?14:12;
    return Container(
      alignment: Alignment.center,
      height: _height / 1.7,
      width: _width,
      padding: EdgeInsets.symmetric(
      vertical:20,horizontal:  _width >= 500 ? 10 : 2,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/back_banner.jpg',
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Container(width: widget.width,
        child: Center(
          child: Form(
            key: _verifyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: _width >= 500 ? 20 : 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Certificate Verification ',
                        style: TextStyle(
                            color: AppColors.text,
                            fontSize: _width >= 800 ? 30 : 20,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TheTextField(
                  hintText: 'Verification code',
                  onChange: (a) => setState(() {
                    _verifyCode = a;
                    // print(_verifyCode);
                  }),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  color: AppColors.primary,
                  onPressed: () async {
                    if (_verifyForm.currentState!.validate()) {

                      await verification(_verifyCode).then((value) {
                        // var data=jsonDecode(value);

                        return value;
                      }).then(
                        (value) => Connect.appDialog(context,
                            title: 'Verification',
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  value['verified']
                                      ?     SelectableText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Successfully Verified\n\n\n\n',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  fontSize: _headingSize),
                            ),
                            TextSpan(
                              text: 'It is notified that ',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .normal,
                                  fontSize: _valueSize),
                            ),
                            TextSpan(
                              text:'${value['body'][0]['name']}',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize: _headingSize),
                            ),
                            TextSpan(
                              text: ' had certified from',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .normal,
                                  fontSize: _valueSize),
                            ),
                            TextSpan(
                              text:' KATE International ',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize: _headingSize),
                            ),
                            TextSpan(
                              text: 'on',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .normal,
                                  fontSize: _valueSize),
                            ),
                            TextSpan(
                              text: ' ${value['body'][0]['initial_date'].toString().substring(0, 4)}/${value['body'][0]['initial_date'].toString().substring(4, 6)}/${value['body'][0]['initial_date'].toString().substring(6, 8)}',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize: _headingSize),
                            ),
                            TextSpan(
                              text: ' and its registration number is given below.',
                              style:  TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .normal,
                                  fontSize: _valueSize),
                            ),

                          ],


                        ),
                                    textAlign: TextAlign.center,
                      ) :
                                  SelectableText.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Not verified\n\n\n\n',
                                          style:  TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              fontSize: _headingSize),
                                        ),
                                        TextSpan(
                                          text:'Your code is not match to any certificate\n',
                                          style:  TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .normal,
                                              fontSize: _valueSize),
                                        ),
                                        TextSpan(
                                          text: 'Please make sure that, you have entered a correct verification code.\n\n',
                                          style:  TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .normal,
                                              fontSize: _valueSize),
                                        ),


                                      ],


                                    ),textAlign: TextAlign.center,
                                  ),
                                  value['verified']
                                      ? const Image(
                                          width: 100,
                                          height: 100,
                                          image: AssetImage(
                                            'assets/images/verify.png',
                                          ))
                                      : const Image(
                                          image: AssetImage(
                                            'assets/images/not_verfied.png',
                                          ),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                  value['verified']
                                      ? Text(
                                          'RegNo: ${value['body'][0]['registration']} ')
                                      : Container(),
                                ],
                              ),
                            )),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
