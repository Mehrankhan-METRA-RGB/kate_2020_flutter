import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/adminPanel/edit_data.dart';
import 'package:kate/authentications/testimonials/testimonial_upload.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';

class TestimonialsView extends StatefulWidget {
  TestimonialsView(
      {required this.width,
      required this.height,
      this.isAdmin = false,
      this.isSeparate = false});
  final double? width;
  final double? height;
  final bool isAdmin;
  final bool isSeparate;

  @override
  _TestimonialsViewState createState() => _TestimonialsViewState();
}

class _TestimonialsViewState extends State<TestimonialsView> {
  final ScrollController _controllerOne = ScrollController();
  Future<List<TestimonialModel>> getData() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/testimonials',
    );
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    List<TestimonialModel> unsortedata =
        decode.map((user) => TestimonialModel.fromJson(user)).toList();
    List<TestimonialModel> list = [];
    for (var date in unsortedata) {
      list.add(date);
    }
    // print(list);
    list.sort((a, b) => -a.date!.compareTo(b.date!));
    return list;
  }

  Future<List<TestimonialModel>>? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  var _height, _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return widget.isSeparate
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Testimonials ',
                style: TextStyle(fontSize: 20),
              ),
              automaticallyImplyLeading: false,
            ),
            body: Container(
              height: _height,
              width: _width,
              child: FutureBuilder<List<TestimonialModel>?>(
                builder: (context, snapshot) {
                  // print(snapshot.data);
                  if (snapshot.hasData) {
                    return Scrollbar(
                      controller: _controllerOne,
                      thickness: 10,
                      thumbVisibility: true,
                      child: Container(
                        width: _width >= 900 ? 900 : _width * 0.95,
                        child: ListView.builder(
                          controller: _controllerOne,
                          itemBuilder: (context, index) {
                            // var date=snapshot.data![index].date_at!;

                            return (snapshot.data!).length < 1
                                ? Center(
                                    child: Text('No testimonials Uploaded'),
                                  )
                                : Container(
                                    width: _width >= 800 ? 800 : _width,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 35, horizontal: 1),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: _width >= 800 ? 800 : _width,
                                          child: Card(
                                            elevation: 2,
                                            color: AppColors.card,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      alignment:
                                                          Alignment.center,
                                                      color: AppColors.primary,
                                                      child: const Icon(
                                                        Icons.format_quote,
                                                        color: AppColors.card,
                                                      )),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(40.0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].detail!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing:
                                                            _width >= 500
                                                                ? 4
                                                                : 2,
                                                        color: Colors.black45,
                                                        fontSize: _width >= 500
                                                            ? 20
                                                            : 15,
                                                        fontFamily:
                                                            'fonts/BebasNeue-Regular.ttf'),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    snapshot.data![index].name!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing:
                                                            _width >= 500
                                                                ? 3
                                                                : 2,
                                                        color:
                                                            AppColors.textBlack,
                                                        fontSize: _width >= 500
                                                            ? 17
                                                            : 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'fonts/Cinzel-ExtraBold.ttf'),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    snapshot.data![index]
                                                        .companyName!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing:
                                                            _width >= 500
                                                                ? 3
                                                                : 2,
                                                        color: Colors.black45,
                                                        fontSize: _width >= 500
                                                            ? 14
                                                            : 9,
                                                        fontFamily:
                                                            'fonts/Comfortaa-Light.ttf'),
                                                  ),
                                                ),
                                                widget.isAdmin
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                          top: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5)),
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topRight,
                                                                  end: Alignment
                                                                      .topLeft,
                                                                  colors: [
                                                                    AppColors
                                                                        .gradient[0],
                                                                    AppColors
                                                                        .gradient[1],
                                                                  ],
                                                                )),
                                                        height: 40,
                                                        // width: _width >= 800 ? 800 : _width,
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  Connect.appAlert(
                                                                      context,
                                                                      title:
                                                                          'Deleting Testimonial',
                                                                      content: Text(
                                                                          'Are you sure to delete this Testimonial?'),
                                                                      okPressed:
                                                                          () async {
                                                                    await Connect.delete(
                                                                        snapshot
                                                                            .data![
                                                                                index]
                                                                            .id,
                                                                        table:
                                                                            'testimonial');
                                                                    Navigator.pop(
                                                                        context);
                                                                    setState(
                                                                        () {});
                                                                  });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  // size: 30,
                                                                  color:
                                                                      AppColors
                                                                          .text,
                                                                )),
                                                            Spacer(),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Connect
                                                                      .appDialog(
                                                                    context,
                                                                    content:
                                                                        Edit(
                                                                      popData: {
                                                                        'detail': snapshot
                                                                            .data![index]
                                                                            .detail!,
                                                                        'companyName': snapshot
                                                                            .data![index]
                                                                            .companyName!,
                                                                        'id': snapshot
                                                                            .data![index]
                                                                            .id!,
                                                                        'name': snapshot
                                                                            .data![index]
                                                                            .name!,
                                                                      },
                                                                      onPress:
                                                                          (a) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      type:
                                                                          'testimonials',
                                                                    ),
                                                                    title:
                                                                        'Testimonial Update',
                                                                  );
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .edit_outlined,
                                                                  // size: 30,
                                                                  color:
                                                                      AppColors
                                                                          .text,
                                                                )),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                          itemCount: (snapshot.data!).length < 1
                              ? 1
                              : (snapshot.data!).length,
                          // ( snapshot.data!).length,
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        LinearProgressIndicator(),
                        Text('loading...'),
                      ],
                    ));
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error occurred while connecting to server!'),
                    );
                  } else {
                    return const Center(child: LinearProgressIndicator());
                  }
                },
                future: getData(),
              ),
            ),
            floatingActionButton: widget.isAdmin
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Connect.appDialog(context,
                          scroll: false,
                          title: 'Upload Job',
                          content: TestimonialsUpload());
                    },
                  )
                : null,
          )
        : Container(
            width: widget.width,
            child: StreamBuilder<List<TestimonialModel>?>(
              builder: (context, snapshot) {
                // print(snapshot.data);
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
// physics:const NeverScrollableScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, index) {
                      // var date=snapshot.data![index].date_at!;

                      return (snapshot.data!).length < 1
                          ? Center(
                              child: Text('No testimonials Uploaded'),
                            )
                          : Container(
                              width: _width >= 900 ? 900 : _width * 0.95,
                              margin: EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 10),
                              child: Card(
                                elevation: 2,
                                color: AppColors.card,
                                child: Container(
                                  width: _width >= 900 ? 900 : _width * 0.98,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Container(
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                            color: AppColors.primary,
                                            child: const Icon(
                                              Icons.format_quote,
                                              color: AppColors.card,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(40.0),
                                        child: Text(
                                          snapshot.data![index].detail!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              letterSpacing:
                                                  _width >= 500 ? 3 : 2,
                                              color: Colors.black45,
                                              fontSize: _width >= 500 ? 20 : 15,
                                              fontFamily:
                                                  'fonts/BebasNeue-Regular.ttf'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          snapshot.data![index].name!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              letterSpacing:
                                                  _width >= 500 ? 3 : 2,
                                              color: AppColors.textBlack,
                                              fontSize: _width >= 500 ? 17 : 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  'fonts/Cinzel-ExtraBold.ttf'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          snapshot.data![index].companyName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              letterSpacing:
                                                  _width >= 500 ? 3 : 2,
                                              color: Colors.black45,
                                              fontSize: _width >= 500 ? 14 : 9,
                                              fontFamily:
                                                  'fonts/Comfortaa-Light.ttf'),
                                        ),
                                      ),
                                      widget.isAdmin
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                top: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.topLeft,
                                                    colors: [
                                                      AppColors.gradient[0],
                                                      AppColors.gradient[1],
                                                    ],
                                                  )),
                                              height: 40,
                                              // width: _width >= 800 ? 800 : _width,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () async {
                                                        Connect.appAlert(
                                                            context,
                                                            title:
                                                                'Deleting Testimonial',
                                                            content: Text(
                                                                'Are you sure to delete this Testimonial?'),
                                                            okPressed:
                                                                () async {
                                                          await Connect.delete(
                                                              snapshot
                                                                  .data![index]
                                                                  .id,
                                                              table:
                                                                  'testimonial');
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        // size: 30,
                                                        color: AppColors.text,
                                                      )),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        Connect.appDialog(
                                                          context,
                                                          content: Edit(
                                                            popData: {
                                                              'detail': snapshot
                                                                  .data![index]
                                                                  .detail!,
                                                              'companyName':
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .companyName!,
                                                              'id': snapshot
                                                                  .data![index]
                                                                  .id!,
                                                              'name': snapshot
                                                                  .data![index]
                                                                  .name!,
                                                            },
                                                            onPress: (a) {
                                                              setState(() {});
                                                            },
                                                            type:
                                                                'testimonials',
                                                          ),
                                                          title:
                                                              'Testimonial Update',
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit_outlined,
                                                        // size: 30,
                                                        color: AppColors.text,
                                                      )),
                                                  Spacer(),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                    itemCount: (snapshot.data!).length < 1
                        ? 1
                        : (snapshot.data!).length,
                    // ( snapshot.data!).length,
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      LinearProgressIndicator(),
                      Text('loading...'),
                    ],
                  ));
                } else if (snapshot.hasError) {
                  return const Center(child: LinearProgressIndicator());
                } else {
                  return const Center(child: LinearProgressIndicator());
                }
              },
              stream: getData().asStream(),
            ),
          );
  }
}

class TestimonialModel {
  final int? id;
  final String? name;
  final String? companyName;
  final String? date;
  final String? detail;
  TestimonialModel(
      {this.date, this.id, this.detail, this.companyName, this.name});
  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'] as int?,
      companyName: json['companyName'] as String?,
      name: json['name'] as String?,
      date: json['date'] as String?,
      detail: json['detail'] as String?,
    );
  }
}
