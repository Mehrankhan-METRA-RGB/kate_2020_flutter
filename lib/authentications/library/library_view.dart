import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/adminPanel/edit_data.dart';
import 'package:kate/authentications/jobs/jobs_upload.dart';
import 'package:kate/authentications/library/library_upload.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/main_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryView extends StatefulWidget {
  LibraryView(
      {this.width,
      this.isAdmin = false,
      this.isSeparate = false,
      this.uploader = 'null',
      this.type = 'document'});
  final double? width;
  final bool isAdmin;
  final uploader;
  final type;
  final bool isSeparate;

  @override
  _LibraryViewState createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  Future<List<LibraryModel>> getData(type) async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/library',
    );
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    // print(decode);
    List<LibraryModel> unsortedata =
        decode.map((user) => LibraryModel.fromJson(user)).toList();
    List<LibraryModel> list = [];
    for (var date in unsortedata) {
      if (type != null) {
        if (date.category!.contains(type)) {
          list.add(date);
        }
      } else {
        list.add(date);
      }
    }

    return list;
  }

  Future<List<LibraryModel>>? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  var _height, _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return widget.isSeparate
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title:  TabBar(
                  onTap: (a)=> setState(() {}),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  // isScrollable: true,
                  indicatorColor: AppColors.primary,
                  indicator:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppColors.primary,
                  ),
                  tabs: const[
                    Tab(height: 30, icon: Text('BOOKS')),
                    Tab(height: 30, icon: Text('HSE DOCS')),

                  ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 40,
                automaticallyImplyLeading: false,
              ),
              body: TabBarView(
                children: [
                  widgetType('book'),
                  widgetType('document'),
                ],
              ),
              floatingActionButton: widget.isAdmin
                  ? FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        Connect.appDialog(context,
                            title: 'Upload Library',
                            scroll: false,
                            content: LibraryUpload(uploader: widget.uploader));
                      },
                    )
                  : null,
            ),
          )
        : widgetType(null);
  }

  Widget widgetType(type) {
    return Center(
      child: Container(
        width: widget.width,
        child: FutureBuilder<List<LibraryModel>?>(
          builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 60),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var url;
                  (snapshot.data!).length < 1
                      ? 'url'
                      : url = snapshot.data![index].url!
                          .replaceRange(11, 12, '//')
                          .replaceRange(18, 19, '//');
                  var _link = (snapshot.data!).length > 0
                      ? 'https://kateintl.com/${snapshot.data![index].url!}'
                      : 'url';
// print(_link.replaceAll('public_html/', ''));
                  return (snapshot.data!).length < 1
                      ? const Center(
                          child: Text('No Documents Uploaded '),
                        )
                      :
                  Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 2, horizontal: _width >= 800 ? 30 : 10),
                          child: Column(children: [
                            Container(
                              width: _width >= 800 ? 760 : _width,
                              child: ListTile(
                                onTap: () async {
                                  await canLaunch(
                                          _link.replaceAll('public_html/', ''))
                                      ? await launch(
                                          _link.replaceAll('public_html/', ''))
                                      : throw 'Could not launch ';
                                },
                                focusColor: AppColors.card.withOpacity(0.5),
                                autofocus: true,
                                title: Row(
                                  children: [
                                    Container(
                                      width:_width >= 600 ? 400 : _width-146,
                                      child: Text(
                                        snapshot.data![index].name!
                                            .replaceAll('+', ' '),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: _width >= 500 ? 14 : 9),
                                      ),
                                    ),
                                    Spacer(),
                                    widget.isAdmin
                                        ? IconButton(
                                            onPressed: () {

                                                Connect.appAlert(context,
                                                    title: 'Deleting ',
                                                    content: const Text(
                                                        'Are you sure to delete this file?'),
                                                    okPressed: () async{

                                                 await Connect.delete(
                                                     snapshot
                                                         .data![
                                                     index]
                                                         .id,table: 'library');
                                                 Navigator.pop(context);
                                                 setState(() {});

                                              });
                                            },
                                            icon: Icon(Icons.delete))
                                        : Container(),
                                  ],
                                ),
                                leading: Image.asset(
                                  'assets/extensions/${snapshot.data![index].extension!.replaceAll('.', '')}.png',
                                  width: 20,
                                  height: 35,
                                ),
                              ),
                            ),
                          ]),
                        );
                },
                itemCount:
                    (snapshot.data!).length < 1 ? 1 : (snapshot.data!).length,
              );
            } else if (!snapshot.hasData) {
              return const LinearProgressIndicator();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Try Again!'),
              );
            } else {
              return const LinearProgressIndicator();
            }
          }else if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const LinearProgressIndicator();
      }
      else if(snapshot.connectionState == ConnectionState.none)
      {
        return const Center( child: Text('No Internet Connection!'),);
      }else{return const LinearProgressIndicator();}
      },
          future: getData(type),
        ),
      ),
    );
  }
}

class LibraryModel {
  final int? id;
  final String? detail;
  final String? url;
  final String? extension;
  final String? category;
  final String? name;

  LibraryModel({
    this.detail,
    this.url,
    this.id,
    this.category,
    this.extension,
    this.name,
  });
  factory LibraryModel.fromJson(Map<String, dynamic> json) {
    return LibraryModel(
      id: json['id'] as int?,
      detail: json['detail'] as String?,
      category: json['category'] as String?,
      url: json['url'] as String?,
      extension: json['extension'] as String?,
      name: json['name'] as String?,
    );
  }
}
