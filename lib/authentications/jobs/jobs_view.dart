import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/adminPanel/edit_data.dart';
import 'package:kate/authentications/jobs/jobs_upload.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';

class JobsView extends StatefulWidget {
  JobsView(
      {this.width,
      this.isAdmin = true,
      this.isSeparate = false,
      this.uploader});
  final double? width;
  final bool isAdmin;
  final uploader;
  final bool isSeparate;

  @override
  _JobsViewState createState() => _JobsViewState();
}

class _JobsViewState extends State<JobsView> {
  Future<List<JobsModel>> getData() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/jobs',
    );
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    // print(decode);
    List<JobsModel> unsortedata =
        decode.map((user) => JobsModel.fromJson(user)).toList();
    List<JobsModel> list = [];
    for (var date in unsortedata) {
      list.add(date);
    }
    list.sort((a, b) => -a.date_at!.compareTo(b.date_at!));
    return list;
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<List<JobsModel>>? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var _height, _width, _headingSize, _valueSize, _titleSize;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _headingSize = _width >= 500 ? 14 : 12;
    _valueSize = _width >= 500 ? 13 : 10;
    _titleSize = _width >= 500 ? 16 : 12;
    return widget.isSeparate
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                'Jobs ',
                style: TextStyle(fontSize: 20),
              ),
              elevation: 0,
              toolbarHeight: 50,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              height: _height,
              width: _width,
              child: FutureBuilder<List<JobsModel>?>(
                builder: (context, snapshot) {
                  // print(snapshot.data);
                  if (snapshot.hasData) {
                    return Scrollbar(
                      thickness: 10,
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var date;
                          (snapshot.data!).length < 1
                              ? date = 1
                              : date = snapshot.data![index].date_at!;

                          return (snapshot.data!).length < 1
                              ? Center(
                                  child: Text('No Jobs Uploaded '),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 35,
                                      horizontal: _width >= 800 ? 200 : 2),
                                  child: Card(
                                    elevation: 2,
                                    color: AppColors.card,
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          initiallyExpanded: true,
                                          textColor: AppColors.textBlack,
                                          childrenPadding:
                                              const EdgeInsets.only(
                                                  bottom: 15,
                                                  left: 5,
                                                  right: 5,
                                                  top: 1),
                                          tilePadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 4),
                                          expandedAlignment:
                                              Alignment.centerLeft,
                                          expandedCrossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index].title_at!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: _titleSize),
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
                                                          .data![index]
                                                          .from_at!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: _valueSize),
                                                    ),
                                                  ],
                                                  text: 'FROM: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: _headingSize),
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
                                                          fontSize: _valueSize),
                                                    ),
                                                  ],
                                                  text: 'DATE: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: _headingSize),
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
                                                          .data![index]
                                                          .category_at!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: _valueSize),
                                                    ),
                                                  ],
                                                  text: 'CATEGORY: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: _headingSize),
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
                                                          .data![index]
                                                          .region_at!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize:
                                                              _headingSize),
                                                    ),
                                                  ],
                                                  text: 'REGION: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
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
                                                          .data![index].id!
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: _valueSize),
                                                    ),
                                                  ],
                                                  text: 'ID: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: _headingSize),
                                                ),
                                              ),
                                              Divider(
                                                color: AppColors.gradient[0]
                                                    .withOpacity(0.3),
                                                thickness: 0.5,
                                              ),
                                            ],
                                          ),
                                          children: [
                                            SelectableText.rich(
                                              TextSpan(
                                                text:
                                                    '''${snapshot.data![index].detail_at!}''',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: _headingSize),
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.gradient[0]
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                          ],
                                        ),
                                        widget.isAdmin
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                  top: 0,
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
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
                                                        onPressed: () {
                                                          setState(() {
                                                            Connect.appAlert(
                                                                context,
                                                                title:
                                                                    'Deleting Job',
                                                                content: Text(
                                                                    'Are you sure to delete this job?'),
                                                                okPressed:
                                                                    () async {
                                                              await Connect.delete(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id,
                                                                  table: 'job');
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context);
                                                            });
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
                                                                'id': snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!,
                                                                'title_at': snapshot
                                                                    .data![
                                                                        index]
                                                                    .title_at!,
                                                                'from_at': snapshot
                                                                    .data![
                                                                        index]
                                                                    .from_at!,
                                                                'region_at': snapshot
                                                                    .data![
                                                                        index]
                                                                    .region_at!,
                                                                'detail_at': snapshot
                                                                    .data![
                                                                        index]
                                                                    .detail_at!,
                                                                'category_at':
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .category_at!,
                                                              },
                                                              type: 'jobs',
                                                              onPress: (a) {
                                                                setState(() {});
                                                              },
                                                            ),
                                                            title:
                                                                "Jobs Update",
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
                                );
                        },
                        itemCount: (snapshot.data!).length < 1
                            ? 1
                            : (snapshot.data!).length,
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    // return const Center(child:  LinearProgressIndicator()());
                    return const Center(child: LinearProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Try Again!'),
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
                          title: 'Upload Job',
                          scroll: false,
                          content: JobsUpload());
                    },
                  )
                : null,
          )
        : FutureBuilder<List<JobsModel>?>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  // physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var date;
                    (snapshot.data!).length < 1
                        ? date = 1
                        : date = snapshot.data![index].date_at!;

                    return (snapshot.data!).length < 1
                        ? Center(
                            child: Text('No Jobs Uploaded '),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 35,
                                horizontal: _width >= 800 ? 200 : 2),
                            child: Column(children: [
                              Card(
                                elevation: 2,
                                color: AppColors.card,
                                child: Column(
                                  children: [
                                    ExpansionTile(
                                      initiallyExpanded: true,
                                      textColor: AppColors.textBlack,
                                      childrenPadding: const EdgeInsets.only(
                                          bottom: 15,
                                          left: 5,
                                          right: 5,
                                          top: 1),
                                      tilePadding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 4),
                                      expandedAlignment: Alignment.centerLeft,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              snapshot.data![index].title_at!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      _width >= 450 ? 16 : 11),
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
                                                          .from_at!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: _valueSize),
                                                    ),
                                                  ],
                                                  text: 'FROM: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: _headingSize),
                                                ),
                                              ),
                                              Spacer(),
                                              MaterialButton(
                                                onPressed: () {
                                                  Connect.mail(
                                                      email: snapshot
                                                          .data![index]
                                                          .from_at!,
                                                      text:
                                                          '''${snapshot.data![index].title_at!}\n\nkateintl.com''');
                                                },
                                                color: AppColors.primary,
                                                child: Text(
                                                  'Mail',
                                                  style: TextStyle(
                                                      color: AppColors.text,
                                                      fontSize: _width >= 500
                                                          ? 12
                                                          : 8),
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
                                                  text:
                                                      '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: _valueSize),
                                                ),
                                              ],
                                              text: 'DATE: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: _headingSize),
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
                                                      .category_at!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: _valueSize),
                                                ),
                                              ],
                                              text: 'CATEGORY: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: _headingSize),
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
                                                      .data![index].region_at!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: _valueSize),
                                                ),
                                              ],
                                              text: 'REGION: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: _headingSize),
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
                                                      .data![index].id!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: _valueSize),
                                                ),
                                              ],
                                              text: 'ID: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: _headingSize),
                                            ),
                                          ),
                                          Divider(
                                            color: AppColors.gradient[0]
                                                .withOpacity(0.3),
                                            thickness: 0.5,
                                          ),
                                        ],
                                      ),
                                      children: [
                                        SelectableText.rich(
                                          TextSpan(
                                            text:
                                                '''${snapshot.data![index].detail_at!}''',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: _headingSize),
                                          ),
                                        ),
                                        Divider(
                                          color: AppColors.gradient[0]
                                              .withOpacity(0.3),
                                          thickness: 0.5,
                                        ),
                                      ],
                                    ),
                                    widget.isAdmin
                                        ? Container(
                                            margin: EdgeInsets.only(
                                              top: 0,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5)),
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
                                                    onPressed: () {
                                                      setState(() {
                                                        Connect.appAlert(
                                                            context,
                                                            title:
                                                                'Deleting Job',
                                                            content: Text(
                                                                'Are you sure to delete this job?'),
                                                            okPressed:
                                                                () async {
                                                          await Connect.delete(
                                                              snapshot
                                                                  .data![index]
                                                                  .id,
                                                              table: 'job');
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        });
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
                                                            'id': snapshot
                                                                .data![index]
                                                                .id!,
                                                            'title_at': snapshot
                                                                .data![index]
                                                                .title_at!,
                                                            'from_at': snapshot
                                                                .data![index]
                                                                .from_at!,
                                                            'region_at':
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .region_at!,
                                                            'detail_at':
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .detail_at!,
                                                            'category_at':
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .category_at!,
                                                          },
                                                          type: 'jobs',
                                                          onPress: (a) {
                                                            setState(() {});
                                                          },
                                                        ),
                                                        title: "Jobs Update",
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
                            ]),
                          );
                  },
                  itemCount:
                      (snapshot.data!).length < 1 ? 1 : (snapshot.data!).length,
                );
              } else if (!snapshot.hasData) {
                return const Center(child: LinearProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: LinearProgressIndicator());
              } else {
                return const Center(child: LinearProgressIndicator());
              }
            },
            future: getData(),
          );
  }
}

class JobsModel {
  final int? id;
  final String? title_at;
  final String? from_at;
  final String? date_at;
  final String? category_at;
  final String? region_at;
  final String? detail_at;
  JobsModel(
      {this.date_at,
      this.title_at,
      this.from_at,
      this.id,
      this.category_at,
      this.detail_at,
      this.region_at});
  factory JobsModel.fromJson(Map<String, dynamic> json) {
    return JobsModel(
      id: json['id'] as int?,
      from_at: json['from_at'] as String?,
      title_at: json['title_at'] as String?,
      date_at: json['date_at'] as String?,
      category_at: json['category_at'] as String?,
      region_at: json['region_at'] as String?,
      detail_at: json['detail_at'] as String?,
    );
  }
}
