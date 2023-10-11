import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/adminPanel/edit_data.dart';
import 'package:kate/authentications/client_course_registration.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';

class TrainingCalender extends StatefulWidget {
  TrainingCalender({this.width, this.isAdmin = false, this.isSeparate = false});
  final double? width;
  final bool isAdmin;
  final bool isSeparate;

  @override
  _TrainingCalenderState createState() => _TrainingCalenderState();
}

class _TrainingCalenderState extends State<TrainingCalender> {
  var _height, _width;
  double? calenderTextSize = 12;
  var traininfListLength = 11;
  Future<List<CalenderModel>> getData() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/calender',
    );
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    List<CalenderModel> unsortedata =
        decode.map((user) => CalenderModel.fromJson(user)).toList();
    List<CalenderModel> list = [];
    for (var date in unsortedata) {
      list.add(date);
    }
    list.sort((a, b) => -a.initdate!.compareTo(b.initdate!));
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return widget.isSeparate
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Training Calender ${DateTime.now().year}',
                style: TextStyle(fontSize: 25),
              ),
              elevation: 0,
              toolbarHeight: 50,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: SafeArea(
                bottom: true,
                child: future(),
              ),
            ),
          )
        : Container(
            // color: AppColors.card,
            width: _width,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  'assets/images/back_banner.jpg',
                  fit: BoxFit.fill,
                  height: _height / 1.6,
                  width: _width,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      child: Text(
                        'Training Calender ${DateTime.now().year} ',
                        style: TextStyle(
                            color: AppColors.text,
                            fontSize: _width >= 800 ? 30 : 20,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 3),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Card(
                      color: Colors.white,
                      child: future(),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget future() {
    return FutureBuilder<List<CalenderModel>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              thumbVisibility: true,
              showTrackOnHover: true,
              thickness: 10,
              child: ListView.builder(
                shrinkWrap: true,
                physics: widget.isSeparate
                    ? null
                    : const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  var date1 = snapshot.data![index].initdate!;
                  var date2 = snapshot.data![index].enddate!;
                  // var initdate='${date1.substring(0,4)}/${date1.substring(4,6)}/${date1.substring(6,7)}';

                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: _width >= 800
                            ? 200
                            : _width < 400
                                ? 5
                                : 20),
                    child: Card(
                      color: AppColors.card,
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.all(15),
                        title: Container(
                          width: _width >= 900 ? 900 : _width - 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data![index].title!,
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width < 800 ? 11 : 14),
                              ),
                              Spacer(),
                              _width > 500
                                  ? Text(
                                      'Initial Date: ${date1.substring(6, 8)}/${date1.substring(4, 6)}/${date1.substring(0, 4)}',
                                      style: TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: _width < 800 ? 11 : 14),
                                    )
                                  : Container(),
                              const SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  snapshot.data![index].seat!,
                                  style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: _width < 600 ? 10 : 14),
                                ),
                                color: (snapshot.data![index].seat!) == 'Booked'
                                    ? const Color(0xffa80202)
                                    : const Color(0xFF01A304),
                              ),
                              SizedBox(
                                width: _width > 1000 ? 10 : 1,
                              ),
                            ],
                          ),
                        ),
                        subtitle: Container(
                          width: _width >= 900 ? 900 : _width - 4,
                          child: Row(
                            children: [
                              Text(
                                snapshot.data![index].subtitle!,
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width > 800 ? 13 : 10),
                              ),
                              Spacer(),
                              Text(
                                'Left: ${DateTime.parse(date2).difference(DateTime.parse(date1)).inDays} days',
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width > 600 ? 11 : 8),
                              ),
                              SizedBox(
                                width: _width > 900 ? 10 : 1,
                              ),
                            ],
                          ),
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STARTING DATE: ${date1.substring(6, 8)}/${date1.substring(4, 6)}/${date1.substring(0, 4)}',
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width < 800 ? 11 : 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'EXAM DATE:  ${date2.substring(6, 8)}/${date2.substring(4, 6)}/${date2.substring(0, 4)}',
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width < 800 ? 11 : 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'LOCATION: ${snapshot.data![index].loc}',
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width < 800 ? 11 : 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'PRICE: ${snapshot.data![index].price}',
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width < 800 ? 11 : 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'DURATION:  ${snapshot.data![index].duration}',
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width < 800 ? 11 : 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'TRAINING FORM:',
                                    style: TextStyle(
                                        color: AppColors.textBlack,
                                        fontSize: _width < 800 ? 11 : 14),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Connect.appDialog(
                                        context,
                                        title:
                                            'Register for ${snapshot.data![index].title}',
                                        content: const ClientCourseRegistration(
                                          isAppBar: false,
                                          isSeparate: false,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: AppColors.text,
                                          fontSize: _width < 600 ? 9 : 13),
                                    ),
                                    color: AppColors.gradient[1],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'SEAT AVAILABLE:  ${snapshot.data![index].seat}',
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: _width < 800 ? 11 : 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          widget.isAdmin
                              ? IconButton(
                                  onPressed: () {
                                    Connect.appDialog(
                                      context,
                                      content: Edit(
                                        popData: {
                                          'id': '${snapshot.data![index].id!}',
                                          'price': snapshot.data![index].price!,
                                          'title': snapshot.data![index].title!,
                                          'subtitle':
                                              snapshot.data![index].subtitle!,
                                          'initdate':
                                              snapshot.data![index].initdate!,
                                          'enddate':
                                              snapshot.data![index].enddate!,
                                          'loc': snapshot.data![index].loc!,
                                          'duration':
                                              snapshot.data![index].duration!,
                                          'seat': snapshot.data![index].seat!,
                                        },
                                        id: snapshot.data![index].id!,
                                        type: 'calenders',
                                        onPress: (a) {
                                          setState(() {});
                                        },
                                      ),
                                      title: "Calender Update",
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: AppColors.primary,
                                    size: 26,
                                  ))
                              : Container()
                        ],
                      ),
                    ),
                  );
                },
                itemCount: (snapshot.data!).length,
              ),
            );
          } else if (!snapshot.hasData) {
            // return const Center(child:  LinearProgressIndicator());
            return const Center(child: LinearProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Try Again!'),
            );
          } else {
            return const Center(child: LinearProgressIndicator());
          }
        });
  }
}

class CalenderModel {
  final int? id;
  final String? title;
  final String? subtitle;
  final String? seat;
  final String? initdate;
  final String? enddate;
  final String? price;
  final String? duration;
  final String? loc;
  final String? detail;
  final String? seatLeft;
  final String? seatTotal;
  CalenderModel(
      {this.subtitle,
      this.title,
      this.seat,
      this.id,
      this.initdate,
      this.price,
      this.enddate,
      this.loc,
      this.detail,
      this.seatLeft,
      this.seatTotal,
      this.duration});
  factory CalenderModel.fromJson(Map<String, dynamic> json) {
    return CalenderModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      subtitle: json['sub_title'] as String?,
      initdate: json['init_date'] as String?,
      enddate: json['end_date'] as String?,
      price: json['price'] as String?,
      duration: json['duration'] as String?,
      loc: json['training_center'] as String?,
      seat: json['seat_availability'] as String?,
      detail: json['detail'] as String?,
      seatLeft: json['seat_left'] as String?,
      seatTotal: json['total_seats'] as String?,
    );
  }
}
