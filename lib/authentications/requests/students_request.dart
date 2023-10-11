import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/adminPanel/edit_data.dart';
import 'package:kate/adminPanel/pdf_certificate.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';

class StudentsRequests extends StatefulWidget {
  StudentsRequests({this.filter});
  final filter;
  static int length = 0;
  @override
  _StudentsRequestsState createState() => _StudentsRequestsState();
}

class _StudentsRequestsState extends State<StudentsRequests> {
  ScrollController _scrollController = ScrollController();
  Future<List<StdModel>>? data;
  final signUpkey = GlobalKey<FormState>();
  Future<List<StdModel>> getData() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/request',
    );
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    List<StdModel> unsortedata =
        decode.map((user) => StdModel.fromJson(user)).toList();
    List<StdModel> list = [];
    for (var date in unsortedata) {
      list.add(date);
    }

    /// get length of list

    list.sort((a, b) => -a.init_date!.compareTo(b.init_date!));

    return list;
  }

  completionDate(date) {
    var initDate = DateTime.parse("$date");
    var completionDate = initDate.add(Duration(days: 180));
// // print(completionDate);
    return completionDate.toString().substring(0, 10).replaceAll('-', '');
  }

  Future register(body) async {
    var res =
        await http.post(Uri.parse("${AppUrl.temp}student/insert"), body: body);
    // print(res.statusCode);
    return res.statusCode;
  }

  @override
  void initState() {
    super.initState();
    // data= getData();
  }

  var _height, _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(elevation: 0,actions: [MainTabBar(),],),
      body: Container(
        height: _height,
        width: _width,
        child: Scrollbar(
          thickness: 10,
          thumbVisibility: true,
          controller: _scrollController,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            // physics:const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const Text(
                  ' Student Requests',
                  style: TextStyle(fontSize: 25),
                ),
                StreamBuilder<List<StdModel>?>(
                  builder: (context, snapshot) {
                    // // print(snapshot.data);
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var date;
                          (snapshot.data!).isEmpty
                              ? date = 1
                              : date = snapshot.data![index].init_date!;

                          return (snapshot.data!).isEmpty
                              ? const Center(
                                  child: Text('No registered student '),
                                )
                              : Container(
                                  // width: _width >= 800 ? 800 : _width,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: _width >= 800
                                          ? 200
                                          : _width < 400
                                              ? 5
                                              : 20),
                                  child: Card(
                                    elevation: 10,
                                    color: AppColors.card,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                                width: _width >= 500 ? 10 : 5,
                                                height: _width >= 500 ? 10 : 5,
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                ))),
                                        ExpansionTile(
                                          // initiallyExpanded: true,
                                          textColor: AppColors.textBlack,
                                          childrenPadding:
                                              const EdgeInsets.only(
                                                  bottom: 15,
                                                  left: 15,
                                                  right: 15,
                                                  top: 1),
                                          tilePadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 4),
                                          expandedAlignment:
                                              Alignment.centerLeft,
                                          expandedCrossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          title: Container(
                                            width: _width >= 800 ? 800 : _width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: _width < 500
                                                            ? 8
                                                            : 9),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  snapshot.data![index].name!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: _width >= 500
                                                          ? 16
                                                          : 12),
                                                ),
                                                Spacer(),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                MaterialButton(
                                                  onPressed: () async {
                                                    var data = {
                                                      "name": snapshot
                                                          .data![index].name,
                                                      "address": snapshot
                                                          .data![index].address,
                                                      "NIC": snapshot
                                                          .data![index].nic,
                                                      "phoneNo": snapshot
                                                          .data![index].phone,
                                                      "nationality": snapshot
                                                          .data![index]
                                                          .nationality,
                                                      "email": snapshot
                                                          .data![index].email,
                                                      "gender": snapshot
                                                          .data![index].gender,
                                                      "trainingMode": snapshot
                                                          .data![index]
                                                          .modeOfTraining,
                                                      "trainingLoc": snapshot
                                                          .data![index]
                                                          .locationOfTrainingCenter,
                                                      "courseChoice": snapshot
                                                          .data![index].course,
                                                      "about": snapshot
                                                          .data![index].about,
                                                      "verification":
                                                          Connect.verification(
                                                        snapshot
                                                            .data![index].nic,
                                                        snapshot.data![index]
                                                            .completion_date,
                                                      ).toString(),
                                                      "registration": Connect
                                                          .registrationNo(
                                                        snapshot
                                                            .data![index].nic,
                                                        snapshot.data![index]
                                                            .completion_date,
                                                      ).toString(),
                                                      "init_date": snapshot
                                                          .data![index]
                                                          .init_date
                                                          .toString(),
                                                      "completion_date":
                                                          snapshot.data![index]
                                                              .completion_date,
                                                    };
// // print(data);
                                                    await register(data)
                                                        .then((value) {
                                                      if (value == 200) {
                                                        // // print(value);
                                                        Connect.delete(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                table:
                                                                    'request')
                                                            .whenComplete(() =>
                                                                Connect.snackBar(
                                                                    context,
                                                                    msg: const Text(
                                                                        'Form has been registered ')));
                                                        setState(() {});
                                                      }
                                                    });
                                                  },
                                                  color: AppColors.primary,
                                                  child: Text(
                                                    'Register',
                                                    style: TextStyle(
                                                        color: AppColors.text,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: _width >= 500
                                                            ? 14
                                                            : 10),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                snapshot.data![index].course!,
                                                style: TextStyle(
                                                    color: AppColors.textBlack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: _width >= 500
                                                        ? 11
                                                        : 10),
                                              ),
                                              Spacer(),
                                            ],
                                          ),

                                          children: [
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: _width >= 500
                                                            ? 13
                                                            : 10),
                                                  ),
                                                ],
                                                text: 'Initial Date: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: _width >= 500
                                                        ? 13
                                                        : 10),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: _width >= 500
                                                            ? 13
                                                            : 10),
                                                  ),
                                                ],
                                                text: 'Last Date: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: _width >= 500
                                                        ? 13
                                                        : 10),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: snapshot
                                                        .data![index].nic!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: _width >= 500
                                                            ? 13
                                                            : 10),
                                                  ),
                                                ],
                                                text: 'NIC: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: _width >= 500
                                                        ? 13
                                                        : 10),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            Row(
                                              children: [
                                                SelectableText.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: snapshot
                                                            .data![index]
                                                            .phone!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize:
                                                                _width >= 500
                                                                    ? 13
                                                                    : 10),
                                                      ),
                                                    ],
                                                    text: 'Phone: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: _width >= 500
                                                            ? 14
                                                            : 12),
                                                  ),
                                                ),
                                                const Spacer(),
                                                MaterialButton(
                                                  onPressed: () {
                                                    Connect.whatsApp(
                                                        phone: snapshot
                                                            .data![index]
                                                            .phone!,
                                                        text:
                                                            '''Congratulation's Mr/Ms ${snapshot.data![index].name!}\n
                                                We have received your form for the (${snapshot.data![index].course!}) \n\n
                                                If you are interested in a course, you may have to pay course fee through bank to confirm your seat for (${snapshot.data![index].course!}) \n\nkateintl.com ''');
                                                  },
                                                  child: Image.asset(
                                                    'assets/logos/whatsapp.png',
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            Row(
                                              children: [
                                                SelectableText.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: snapshot
                                                            .data![index]
                                                            .email!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize:
                                                                _width >= 500
                                                                    ? 13
                                                                    : 10),
                                                      ),
                                                    ],
                                                    text: 'Email: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: _width >= 500
                                                            ? 14
                                                            : 12),
                                                  ),
                                                ),
                                                Spacer(),
                                                MaterialButton(
                                                  onPressed: () {
                                                    Connect.mail(
                                                        email: snapshot
                                                            .data![index]
                                                            .email!,
                                                        text:
                                                            ''' Dear ${snapshot.data![index].name!} (kateintl.com)''');
                                                  },
                                                  color: AppColors.primary,
                                                  child: Text(
                                                    'Mail',
                                                    style: TextStyle(
                                                        color: AppColors.text,
                                                        fontSize: _width >= 500
                                                            ? 16
                                                            : 11),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: snapshot
                                                        .data![index].gender,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: _width >= 500
                                                            ? 13
                                                            : 10),
                                                  ),
                                                ],
                                                text: 'Gender: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: _width >= 500
                                                        ? 13
                                                        : 10),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: snapshot
                                                        .data![index].course,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: _width >= 500
                                                            ? 13
                                                            : 10),
                                                  ),
                                                ],
                                                text: 'Course: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: _width >= 500
                                                        ? 13
                                                        : 10),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            SelectableText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: snapshot.data![index]
                                                        .modeOfTraining,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: _width >= 500
                                                            ? 13
                                                            : 10),
                                                  ),
                                                ],
                                                text: 'Mode of Training: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: _width >= 500
                                                        ? 13
                                                        : 10),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Connect.appAlert(context,
                                                          title:
                                                              'Deleting Student',
                                                          content: const Text(
                                                              'Are you sure to delete this Student?'),
                                                          okPressed: () async {
                                                        await Connect.delete(
                                                            snapshot
                                                                .data![index]
                                                                .id,
                                                            table: 'request');
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  MaterialButton(
                                                    onPressed: () async {
                                                      var data = {
                                                        "id": snapshot
                                                            .data![index].id
                                                            .toString(),
                                                        "name": snapshot
                                                            .data![index].name,
                                                        "address": snapshot
                                                            .data![index]
                                                            .address,
                                                        "NIC": snapshot
                                                            .data![index].nic
                                                            .toString(),
                                                        "phone": snapshot
                                                            .data![index].phone,
                                                        "nationality": snapshot
                                                            .data![index]
                                                            .nationality,
                                                        "email": snapshot
                                                            .data![index].email,
                                                        "gender": snapshot
                                                            .data![index].gender
                                                            .toString(),
                                                        "trainingMode": snapshot
                                                            .data![index]
                                                            .modeOfTraining
                                                            .toString(),
                                                        "trainingLoc": snapshot
                                                            .data![index]
                                                            .locationOfTrainingCenter
                                                            .toString(),
                                                        "courseChoice": snapshot
                                                            .data![index].course
                                                            .toString(),
                                                        "about": snapshot
                                                            .data![index].about
                                                            .toString(),
                                                        "init_date": snapshot
                                                            .data![index]
                                                            .init_date
                                                            .toString(),
                                                      };
                                                      Connect.appDialog(context,
                                                          scroll: true,
                                                          title:
                                                              'Update Request',
                                                          content: Edit(
                                                            type: EditType()
                                                                .studentRequests,
                                                            id: snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            popData: data,
                                                            onPress: (a) =>
                                                                setState(() {}),
                                                          ));
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                        itemCount: (snapshot.data!).length < 1
                            ? 1
                            : (snapshot.data!).length,
                      );
                    } else if (!snapshot.hasData) {
                      // return const Center(childLinearlarProgressIndicator());
                      return const Center(child: LinearProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: LinearProgressIndicator());
                    } else {
                      return const Center(child: LinearProgressIndicator());
                    }
                  },
                  stream: getData().asStream(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double? size(px) {
    // var w_px=1056;
    // var h_px=816;
    var c_to_inch_w = px / 96;
    var to_dp_w = c_to_inch_w * 160;
    var to_fUnit_w = to_dp_w / 2;
    // print('Flutter size Unit: $to_fUnit_w');
    return to_fUnit_w;
  }
}

// class StdModel {
//   final int? id;
//   final String? name;
//   final String? address;
//   final String? init_date;
//   final String? completion_date;
//   final String? nic;
//   final String? phone;
//   final String? email;
//   final String? nationality;
//   final String? gender;
//   final String? modeOfTraining;
//   final String? locationOfTrainingCenter;
//   final String? course;
//   final String? about;
//   final String? verificationNo;
//   final String? registrationNo;
//   final String? billDetails;
//   final String? amountPaid;
//   final String? totalCourseAmnt;
//   StdModel(
//       {this.init_date,
//         this.completion_date,
//         this.name,
//         this.address,
//         this.id,
//         this.nic,
//         this.email,
//         this.phone,
//         this.nationality,
//         this.gender,
//         this.modeOfTraining,
//         this.locationOfTrainingCenter,
//         this.course,
//         this.about,
//         this.verificationNo,
//         this.registrationNo,
//         this.billDetails,
//         this.amountPaid,
//         this.totalCourseAmnt});
//   factory StdModel.fromJson(Map<String, dynamic> json) {
//     return StdModel(
//       id: json['id'] as int?,
//       address: json['address'] as String?,
//       name: json['name'] as String?,
//       init_date: json['initial_date'] as String?,
//       completion_date: json['completion_date'] as String?,
//       nic: json['nic'] as String?,
//       phone: json['phone'] as String?,
//       email: json['email'] as String?,
//       gender: json['gender'] as String?,
//       nationality: json['nationality'] as String?,
//       modeOfTraining: json['modeOfTraining'] as String?,
//       locationOfTrainingCenter: json['training_center_loc'] as String?,
//       course: json['course'] as String?,
//       about: json['about'] as String?,
//       verificationNo: json['verification'] as String?,
//       registrationNo: json['registration'] as String?,
//       billDetails: json['bill_details'] as String?,
//       amountPaid: json['amount_paid'] as String?,
//       totalCourseAmnt: json['total'] as String?,
//     );
//   }
// }
