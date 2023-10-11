import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/dashboard.dart';

import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:kate/widgets/textfield.dart';


class SignInAdmin extends StatefulWidget {
  @override
  _SignInAdminState createState() => _SignInAdminState();
}

class _SignInAdminState extends State<SignInAdmin> {
  var _width, _height;
  var _email, _pass;
  Future signIn() async {
    // var response;
    Response response;
    var dio = Dio();
    response = await dio.post("${AppUrl.temp}sign_admin_blog",
        data: {'email': _email, 'password': _pass});
    // print(response.data.toString());
    // response =  http.post(Uri.parse("${AppUrl.temp}sign_admin_blog"),body:{'email': _email, 'password': _pass},
    //     );
    Map<String, dynamic> diodata = {
      'statusCode': response.statusCode,
      'body': response.data,
    };
    var data = jsonEncode(diodata);
    print(data);
    return data;
  }
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obsecure = true;
  final signUpkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login as Admin',
          style: TextStyle(
              // // textStyle:,
              // color: Colors.white70,
              ),
        ),
      ),
      body: Center(
        child: Container(
            width: _width>=900?900:_width-30,
            height: _height,
            child:  ListView(
              shrinkWrap: true,
                children: [

                 Form(
                      key: signUpkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _width>=900?900:_width-30,
                            color: AppColors.gradient[0],
                            child: ExpansionTile(
                              textColor: Colors.black87,
                              collapsedTextColor: Colors.black87,
                              initiallyExpanded: true,
                              backgroundColor: AppColors.gradient[0],
                              title: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    AppColors.gradient[0],
                                    AppColors.gradient[1]
                                  ],
                                )),
                                child: ListTile(
                                  title: Text(
                                    'Important Information',
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: _width > 598.0 ? 18 : 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '(Please read this instructions carefully before you fill this form)',
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: _width > 598.0 ? 14 : 10,
                                    ),
                                  ),
                                ),
                              ),
                              childrenPadding: EdgeInsets.all(25),
                              children: const [
                                SelectableText.rich(TextSpan(
                                  text:
                                      ''' + This area is only for Admins.\n + If you are not an admin We suggest you leave this page as soon as possible . Because we area collecting Admins data.  In Case you are not in our admin list it may leads to your google account suspension.\n + If you forget your email and password please contact customer services admin to regenerate your email or password for you''',
                                  style: TextStyle(
                                    color: AppColors.text,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Container(width: _width>=900?900:_width-30,
                            child: TheTextField(
                              hintText: 'Email',
                              validator: (a) {
                                RegExp _email = RegExp(
                                    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
                                String? aa;
                                if (!_email.hasMatch(a!)) {
                                  aa =
                                      'Enter the Correct Email.  i.e : (abcd@domain.com)';
                                }
                                return aa;
                              },
                              onChange: (a) => setState(() {
                                _email = a;

                              }),
                            ),
                          ),
                          Container(width: _width>=900?900:_width-30,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.black,
                                color: AppColors.card,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: TextFormField(
                                  obscureText: _obsecure,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (a) {
                                    _pass = a;

                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obsecure = !_obsecure;
                                          });
                                        },
                                        icon: Icon(
                                          _obsecure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: _obsecure
                                              ? AppColors.iconsBlack
                                              : AppColors.primary,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.black54),
                                      hintText: 'Enter Password...',
                                      labelText: 'Password',
                                      filled: true,
                                      hoverColor: Color(0xBAD2D1CF),
                                      focusColor: AppColors.primary,
                                      fillColor: Color(0xE6EFEFEF)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16.0),
                                  child: MaterialButton(
                                    focusElevation: 5,
                                    onPressed: () async {
                                      if (signUpkey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.

                                        await signIn().then((value) {
                                          var data = jsonDecode(value);
                                          // print(data);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(elevation: 15,
                                            backgroundColor: AppColors.primary,
                                            content: Text(
                                              data['statusCode'] == 200
                                                  ? "Successfully Logged In ${data['body'][0]['name_at']}"
                                                  : "Connection slow!! Also check Email & Pass",
                                              style: TextStyle(
                                                color:   data['statusCode'] == 200
                                                    ? Colors.black87
                                                    : Colors.red,
                                              ),
                                            ),
                                          ));
                                          return data['body'][0]['name_at'];
                                        }).then((value) {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard(uploader: value,)));
                                        }  );
                                      }
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5)),
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft,
                                              colors: [
                                                AppColors.gradient[0],
                                                AppColors.gradient[1],
                                              ],
                                            )),
                                        child: Row(
                                          children: const [
                                            Text(
                                              'Admin Login',
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),

          ),
      ),

    );
  }
}
