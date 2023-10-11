// import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/data.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/footer.dart';
import 'package:kate/widgets/textfield.dart';
import 'package:velocity_x/velocity_x.dart';

var _width, _height;

class ClientCourseRegistration extends StatefulWidget {
  const ClientCourseRegistration(
      {Key? key, this.width, this.isAppBar = false, this.isSeparate = false})
      : super(key: key);
  final bool isAppBar;
  final double? width;
  final bool isSeparate;
  @override
  _ClientCourseRegistrationState createState() =>
      _ClientCourseRegistrationState();
}

class _ClientCourseRegistrationState extends State<ClientCourseRegistration> {
  String? pass,
      confirmPass,
      name,
      address,
      postalCode,
      nic,
      phoneNo,
      email,
      nationality;
  Object? _trainingMode;
  Object? _trainingLoc;
  late String formatedDate = '';
  Object? _courseChoice;

  late String msg;
  final signUpkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future register() async {
    var res = await http
        .post(Uri.parse("${AppUrl.temp}student/request/insert"), body: {
      "name": name,
      "address": address,
      "NIC": nic,
      "phoneNo": phoneNo,
      "email": email,
      "gender": selectedGender,
      "nationality": nationality,
      "trainingMode": _trainingMode,
      "trainingLoc": _trainingLoc,
      "courseChoice": _courseChoice,
      "about": about,
      // "verification": verification().toString(),
      // "registration": registrationNo().toString(),
      "init_date": formatedDate.toString().substring(0, 10).replaceAll('-', ''),
      "completion_date": Connect.completionDate(formatedDate).toString(),
    });

    return res.statusCode;
  }

  List gender = ["Male", "Female", "Other"];
  List abouts = ["Ads", "News", "word of mouth"];
  Object? about;
  Object? selectedGender;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return widget.isSeparate
        ? Scaffold(
            appBar: widget.isAppBar
                ? AppBar(
                    title: const Text(
                      'Register For Course',
                      style: TextStyle(
                        // textStyle:,
                        color: Colors.white70,
                      ),
                    ),
                  )
                : null,
            body: Center(
              child: Container(
                width: _width,
                height: _height,
                child: Scrollbar(
                  thickness: 10,
                  thumbVisibility: true,
                  child: form(),
                ),
              ),
            ),
          )
        : form();
  }

  Widget form() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: widget.width,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: _width > 600 ? 600 : _width,
              child: Form(
                key: signUpkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.gradient[1],
                      child: ExpansionTile(
                        textColor: AppColors.text,
                        collapsedTextColor: AppColors.text,
                        initiallyExpanded: false,
                        collapsedBackgroundColor: AppColors.gradient[0],
                        backgroundColor: AppColors.gradient[0],
                        title: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                            colors: [
                              AppColors.gradient[0],
                              AppColors.gradient[1],
                            ],
                          )),
                          child: ListTile(
                            title: Text(
                              'Important Information',
                              style: TextStyle(
                                fontSize: _width > 598.0 ? 18 : 16,
                              ),
                            ),
                            subtitle: Text(
                              '(Please read this instructions carefully before you fill this form)',
                              style: TextStyle(
                                fontSize: _width > 598.0 ? 14 : 10,
                              ),
                            ),
                          ),
                        ),
                        childrenPadding: EdgeInsets.all(25),
                        children: [
                          SelectableText.rich(TextSpan(
                            text:
                                '''1: Please ensure this form is filled completely with the correct information and submitted at least 2 weeks to the commencement of the training. Confirm date from the Training Calendar.

2: Please note that filling this registration form does not automatically guarantee a seat for the training until you make a minimum of 50% payment at least 2 weeks to the commencement of the training.

3: The full course cost covers your training fee, exam registration, British Council registration, course text book, project fee and refreshment.

4: Incomplete course payment does not cover exam registration.

5: If you wish to visit the office for registration, our addresses can be found on the Contact Us section of this website.

6: Once we receive your form, we will send you an invoice containing the payment instruction.

7: You will be required to make payment (either full or 50% instalment) before closing date of training which will be indicated in the course invoice.

8: If you require further clarifications, please reach us on ${AppUrl.phoneNo} ''',
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: _width > 598.0 ? 14 : 10,
                            ),
                          )),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal',
                            style:
                                TextStyle(fontSize: _width > 598.0 ? 33 : 25),
                          ),
                          Divider(),
                        ],
                      ),
                    ),

                    TheTextField(
                      hintText: 'Full Name',
                      validator: (a) {},
                      onChange: (a) => setState(() {
                        name = a;
                      }),
                    ),
                    TheTextField(
                      hintText: 'Address',
                      onChange: (a) => setState(() {
                        address = a;
                      }),
                    ),

                    TheTextField(
                      hintText: 'NIC',
                      validator: (a) {
                        RegExp _numeric = RegExp(r'^-?[0-9]+$');
                        String? aa;
                        if (!_numeric.hasMatch(a!)) {
                          // print(a);
                          aa = 'Only Numeric data are allowed';
                        }
                        return aa;
                      },
                      onChange: (a) => setState(() {
                        nic = a;
                      }),
                    ),
                    // TheTextField(
                    //   hintText: 'Phone Number',
                    //   validator: (a) {
                    //     RegExp _numeric = RegExp(r'^-?[0-9]+$');
                    //     String? aa;
                    //     if (!_numeric.hasMatch(a!)) {
                    //       aa = 'Only numbers allowed in this field';
                    //     }
                    //     return aa;
                    //   },
                    //   onChange: (a) => setState(() {
                    //     phoneNo = a;
                    //   }),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: AppColors.card,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: IntlPhoneField(
                          autoValidate: true,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            // alignLabelWithHint: true,
                            border: InputBorder.none,

                            hintStyle: TextStyle(color: Colors.black54),
                            filled: true,
                            hintText: 'Enter WhatsApp No...',
                            labelText: ' WhatsApp Number',

                            hoverColor: Color(0xBAD2D1CF),
                            focusColor: AppColors.primary,
                            fillColor: Color(0xE6EFEFEF),
                          ),
                          initialCountryCode: 'PK',
                          onChanged: (phone) {
                            // print(phone.completeNumber);
                            phoneNo = phone.completeNumber;
                          },
                        ),
                      ),
                    ),

                    TheTextField(
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
                        email = a;
                      }),
                    ),
                    TheTextField(
                      hintText: 'Nationality',
                      validator: (a) {
                        RegExp _numeric = RegExp(r'^-?[a-zA-Z]+$');
                        String? aa;
                        if (!_numeric.hasMatch(a!)) {
                          aa =
                              'Numbers & Special character are not allowed in this field';
                        }
                        return aa;
                      },
                      onChange: (a) => setState(() {
                        nationality = a;
                      }),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 15),
                      child: _width > 598.0
                          ? Row(
                              children: <Widget>[
                                Text(
                                  'Select Gender',
                                  style: TextStyle(
                                      fontSize: _width > 598.0 ? 20 : 16),
                                ),
                                Spacer(),
                                addRadioButton(0, 'Male'),
                                addRadioButton(1, 'Female'),
                                addRadioButton(2, 'Others'),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Select Gender',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Divider(),
                                addRadioButton(0, 'Male'),
                                addRadioButton(1, 'Female'),
                                addRadioButton(2, 'Others'),
                              ],
                            ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Education',
                            style:
                                TextStyle(fontSize: _width > 598.0 ? 33 : 25),
                          ),
                          Divider(),
                        ],
                      ),
                    ),

                    ///Training Mode
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: AppColors.card,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            isExpanded: true,
                            iconSize: 25,
                            elevation: 10,
                            // icon: Icon(Icons.font_download),
                            hint: const Text('Choose Mode of Training'),
                            dropdownColor: Colors.white,
                            value: _trainingMode,
                            items: const [
                              DropdownMenuItem(
                                child: Text('Classroom Training'),
                                value: 'Physical',
                              ),
                              DropdownMenuItem(
                                child: Text('Online Training'),
                                value: 'Online',
                              ),
                            ],

                            onChanged: (Object? a) {
                              setState(() {
                                _trainingMode = a!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    ///Location of Training
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: AppColors.card,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            isExpanded: true,
                            iconSize: 25,
                            elevation: 9,
                            // icon: Icon(Icons.font_download),
                            hint: const Text('Select Location'),
                            dropdownColor: Colors.white,
                            value: _trainingLoc,
                            items: const [
                              DropdownMenuItem(
                                child: ListTile(
                                  title: Text('Mardan Shergarh'),
                                ),
                                value: 'Shergarh Mardan',
                              ),
                            ],

                            onChanged: (Object? a) {
                              setState(() {
                                _trainingLoc = a!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    ///Course Choice
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: AppColors.card,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            isExpanded: true,
                            iconSize: 25,
                            elevation: 9,
                            // icon: Icon(Icons.font_download),
                            hint: const Text('Course Choice'),
                            dropdownColor: Colors.white,
                            value: _courseChoice,
                            items: [
                              DropdownMenuItem(
                                child: Text('IOSH Managing Safety '),
                                value: Data.courses[0],
                              ),
                              DropdownMenuItem(
                                child: Text('ISO 9001 QMS'),
                                value: Data.courses[1],
                              ),
                              DropdownMenuItem(
                                child: Text('ISO 45001 OHSMS'),
                                value: Data.courses[2],
                              ),
                              DropdownMenuItem(
                                child: Text('ISO 14001 EMS'),
                                value: Data.courses[3],
                              ),
                              DropdownMenuItem(
                                child:
                                    Text('OSHA (IASP) 30 Hr- General Industry'),
                                value: Data.courses[4],
                              ),
                              DropdownMenuItem(
                                child: Text('OSHA - 48 Hr'),
                                value: Data.courses[5],
                              ),
                              DropdownMenuItem(
                                child: Text('First Aid Level 2&3'),
                                value: Data.courses[6],
                              ),
                              DropdownMenuItem(
                                child: Text('Fire Safety Level 2&3'),
                                value: Data.courses[7],
                              ),
                              DropdownMenuItem(
                                child: Text('Risk Assessment Level 2&3'),
                                value: Data.courses[8],
                              ),
                              DropdownMenuItem(
                                child: Text('Food Safety'),
                                value: Data.courses[9],
                              ),
                              DropdownMenuItem(
                                child: Text('OTHM LEVEL 6 Diploma'),
                                value: Data.courses[10],
                              ),
                            ],

                            onChanged: (Object? a) {
                              setState(() {
                                _courseChoice = a!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: AppColors.card,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return AppColors.gradient[0]
                                        .withOpacity(0.3);
                                  }
                                  if (states.contains(MaterialState.hovered)) {
                                    return const Color(0xBAD2D1CF);
                                  }
                                  return const Color(
                                      0xE6EFEFEF); // Use the component's default.
                                }),
                              ),
                              onPressed: () {
                                _showDatePicker();
                              },
                              child: Container(
                                height: 55,
                                padding: EdgeInsets.only(right: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      'Indicate Date of Training',
                                      style: TextStyle(
                                        fontSize: _width > 598.0 ? 18 : 11,
                                        color: AppColors.textBlack,
                                      ),
                                    ),
                                    SizedBox(
                                      width: _width > 598.0 ? 20 : 10,
                                    ),
                                    Icon(
                                      Icons.date_range,
                                      size: _width > 598.0 ? 28 : 18,
                                      color: AppColors.iconsBlack,
                                    ),
                                    Spacer(),
                                    Text(
                                      formatedDate != ''
                                          ? formatedDate
                                          : 'YY-MM-DD',
                                      style: TextStyle(
                                        fontSize: _width > 598.0 ? 20 : 12,
                                        color: AppColors.textBlack,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        )),

                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Additional Information',
                            style:
                                TextStyle(fontSize: _width > 598.0 ? 33 : 25),
                          ),
                          Divider(),
                          Text(
                            'How do you hear about Kate International?',
                            style: TextStyle(
                              fontSize: _width > 598.0 ? 18 : 16,
                            ),
                          ),
                          aboutRadioButton(0, 'Ads'),
                          aboutRadioButton(1, 'News'),
                          aboutRadioButton(2, 'Word of Mouth'),
                        ],
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Details',
                              style:
                                  TextStyle(fontSize: _width > 598.0 ? 33 : 25),
                            ),
                            Divider(),
                            Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              color: AppColors.card,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.topLeft,
                                      colors: [
                                        AppColors.gradient[0],
                                        AppColors.gradient[1],
                                      ],
                                    )),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppUrl.Bank1,
                                          style: TextStyle(
                                            fontSize: _width > 598.0 ? 18 : 16,
                                            color: AppColors.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const ListTile(
                                    title: Text(
                                      'Account Name:',
                                      style: TextStyle(
                                        color: AppColors.appBar,
                                      ),
                                    ),
                                    subtitle: SelectableText(AppUrl.AccName1),
                                  ),
                                  Divider(),
                                  const ListTile(
                                    title: Text(
                                      'Account Number:',
                                      style: TextStyle(
                                        color: AppColors.appBar,
                                      ),
                                    ),
                                    subtitle: SelectableText(AppUrl.AccNo1),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              color: AppColors.card,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.topLeft,
                                      colors: [
                                        AppColors.gradient[0],
                                        AppColors.gradient[1],
                                      ],
                                    )),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppUrl.Bank2,
                                          style: TextStyle(
                                            fontSize: _width > 598.0 ? 18 : 16,
                                            color: AppColors.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const ListTile(
                                    title: Text(
                                      'Account Name:',
                                      style: TextStyle(
                                        color: AppColors.appBar,
                                      ),
                                    ),
                                    subtitle: SelectableText(AppUrl.AccName2),
                                  ),
                                  const Divider(),
                                  const ListTile(
                                    title: Text(
                                      'Account Number:',
                                      style: TextStyle(
                                        color: AppColors.textBlack,
                                      ),
                                    ),
                                    subtitle: SelectableText(AppUrl.AccNo2),
                                  ),
                                ],
                              ),
                            ),
                            const ListTile(
                              title: Text(
                                'I Hereby Declare:',
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                ),
                              ),
                              subtitle: SelectableText('''
(1): that the information given in this form is, to the best of my knowledge accurate in every detail;

(2): that if I am shortlisted for the training & examination, I shall keep the rules and regulations of Kate International  Ltd

(3): and if at any time it is discovered that the information I have given is false or incorrect, I will be made to forfeit writing all examinations and(or) possible admission'''),
                            ),
                          ],
                        )),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: MaterialButton(
                            onPressed: () async {
                              if (signUpkey.currentState!.validate()) {
                                await register().then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    duration: const Duration(seconds: 6),
                                    backgroundColor: AppColors.primary,
                                    content: Text(
                                      value == 200
                                          ? "Registration Form submitted successfully. We will let you notify through whatsApp and Email for further details"
                                          : "An unknown error occurred.",
                                      style: TextStyle(
                                          color: value == 200
                                              ? AppColors.text
                                              : Colors.red),
                                    ),
                                  ));
                                  return value;
                                }).then(
                                  (value) => value == 200
                                      ? widget.isSeparate
                                          ? VxNavigator.of(context)
                                              .replace(Uri(path: '/home'))
                                          : Navigator.pop(context)
                                      : Connect.snackBar(context,
                                          msg: const Text('Try Again ')),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
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
                                    'SUBMIT FORM',
                                    style: TextStyle(
                                        fontSize: 18, color: AppColors.text),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Footer(),
          ],
        ),
      ),
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Radio(
          activeColor: AppColors.primary,
          value: gender[btnValue],
          groupValue: selectedGender,
          onChanged: (dynamic value) {
            setState(() {
              selectedGender = value;
              // print(selectedGender);
            });
          },
        )),
        Text(
          title,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Row aboutRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Radio(
          activeColor: AppColors.primary,
          value: abouts[btnValue],
          groupValue: about,
          onChanged: (dynamic value) {
            setState(() {
              about = value;
              // print(about);
            });
          },
        )),
        Text(
          title,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010, 8),
        lastDate: DateTime(2030, 8));
    if (picked != null) {
      setState(() {
        var numdate = picked.toString().substring(0, 10).replaceAll('-', '');
        // print('picked: $numdate');
        var date = picked.toString().substring(0, 10);
        formatedDate = date;
        // DateFormat("yyyy/MM/dd").format(picked);
      });
      // print(formatedDate);
    }
  }
}
