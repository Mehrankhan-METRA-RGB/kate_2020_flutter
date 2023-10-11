import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/adminPanel/edit_data.dart';
import 'package:kate/authentications/blog/upload_blog.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/read_more_text.dart';

class BlogsView extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isAdmin;
  final uploader;
  final bool isSeparate;
  BlogsView(
      {this.width,
      this.height,
      this.isAdmin = false,
      this.isSeparate = false,
      this.uploader});
  @override
  _BlogsViewState createState() => _BlogsViewState();
}

class _BlogsViewState extends State<BlogsView> {
  Future<List<BlogModel>>? fetchBlogs;
  final ScrollController _scrollController = ScrollController();
  Future<List<BlogModel>> getData() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/blogs',
    );

    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    List<BlogModel> unsortedata =
        decode.map((user) => BlogModel.fromJson(user)).toList();
    List<BlogModel> list = [];
    for (var date in unsortedata) {
      list.add(date);
    }
    list.sort((a, b) => -a.dateTime_at!.compareTo(b.dateTime_at!));
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var _width, _height;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return widget.isSeparate
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Blogs ',
                style: TextStyle(fontSize: 20),
              ),
              elevation: 0,
              toolbarHeight: 50,
              leadingWidth: 0,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              width: _width,
              height: _height,
              alignment: Alignment.center,
              child: FutureBuilder<List<BlogModel>?>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Scrollbar(
                      thickness: 10,
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          // ignore: valid_regexps
                          String? url;
                          var date;
                          (snapshot.data!).length < 1
                              ? 'url'
                              : url = snapshot.data![index].imageUrl_at!
                                  .replaceAll('public_html/', '');
                          (snapshot.data!).length < 1
                              ? 1
                              : date = snapshot.data![index].dateTime_at!;
                          return (snapshot.data!).length < 1
                              ? Center(child: Text('No Blogs uploaded'))
                              : Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: 30),
                                  width: widget.width,
                                  child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.black87,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: widget.width,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 0.2,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: Text(
                                                  snapshot
                                                      .data![index].title_at!,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    // AppColors.text,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        _width > 700 ? 23 : 15,
                                                  ),
                                                ),
                                              ),

                                              Image(
                                                image: NetworkImage(
                                                    'https://kateintl.com/${url!}',
                                                    scale: 1.0),
                                                width: widget.width,
                                                height: _width >= 500
                                                    ? 350
                                                    : _width - 150,
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  //   border:Border.all(
                                                  //     width: 0.2,
                                                  //     color: Colors.black
                                                  // ),
                                                  color: Colors.black12,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                height: 18,
                                                width: widget.width,
                                                margin: EdgeInsets.only(
                                                  bottom: 3,
                                                ),
                                                child: Text(
                                                  '  Uploaded by ${snapshot.data![index].uploader_at!} on ${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}  ${date.substring(8, 10)}:${date.substring(10, 12)}:${date.substring(12, 14)}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          _width > 700 ? 12 : 9,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Container(
                                                width: widget.width,
                                                padding: EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5),
                                                child: ReadMoreText(
                                                  snapshot
                                                      .data![index].post_at!,
                                                  style: TextStyle(
                                                    fontSize:
                                                        _width > 700 ? 16 : 12,
                                                  ),
                                                  trimLines: 2,
                                                  colorClickableText:
                                                      AppColors.gradient[0],
                                                  trimMode: TrimMode.Length,
                                                  trimCollapsedText:
                                                      '\nSHOW MORE...',
                                                  trimExpandedText:
                                                      '\nSHOW LESS...',
                                                ),
                                              ),
                                              // ignore: sized_box_for_whitespace
                                              Container(
                                                width: widget.width,
                                                child: Divider(
                                                  height: 14,
                                                  color: AppColors.gradient[0],
                                                ),
                                              ),

                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 5,
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
                                                  gradient: widget.isAdmin
                                                      ? LinearGradient(
                                                          begin: Alignment
                                                              .topRight,
                                                          end:
                                                              Alignment.topLeft,
                                                          colors: [
                                                            AppColors
                                                                .gradient[0],
                                                            AppColors
                                                                .gradient[1],
                                                          ],
                                                        )
                                                      : null,
                                                ),
                                                height: widget.isAdmin ? 40 : 1,
                                                width: widget.width,
                                                child: widget.isAdmin
                                                    ? Row(
                                                        children: [
                                                          Spacer(),
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                Connect.appAlert(
                                                                    context,
                                                                    title:
                                                                        'Deleting Post',
                                                                    content:
                                                                        const Text(
                                                                            'Are you sure to delete this Post?'),
                                                                    okPressed:
                                                                        () {
                                                                  Connect.delete(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .id,
                                                                      table:
                                                                          'blog');
                                                                  setState(
                                                                      () {});
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                // size: 30,
                                                                color: AppColors
                                                                    .text,
                                                              )),
                                                          const Spacer(),
                                                          IconButton(
                                                              onPressed: () {
                                                                Connect.appDialog(
                                                                    context,
                                                                    content:
                                                                        Edit(
                                                                      popData: {
                                                                        'id': snapshot
                                                                            .data![index]
                                                                            .id!,
                                                                        'title': snapshot
                                                                            .data![index]
                                                                            .title_at!,
                                                                        'image': snapshot
                                                                            .data![index]
                                                                            .imageUrl_at!,
                                                                        'detail': snapshot
                                                                            .data![index]
                                                                            .post_at!,
                                                                      },
                                                                      type:
                                                                          'blogs',
                                                                      onPress:
                                                                          (a) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                    ),
                                                                    title:
                                                                        'Blog Update');
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .edit_outlined,
                                                                // size: 30,
                                                                color: AppColors
                                                                    .text,
                                                              )),
                                                          Spacer(),
                                                        ],
                                                      )
                                                    : Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                        itemCount: (snapshot.data!).length < 1
                            ? 1
                            : (snapshot.data)!.length,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Try Again!'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(child: LinearProgressIndicator());
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
                          title: 'Upload Blog',
                          content: BlogUpload(
                            uploader: widget.uploader,
                            isSeparate: false,
                          ));
                    },
                  )
                : null,
          )
        : Container(
            width: widget.width,
            height: _height,
            child: FutureBuilder<List<BlogModel>?>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      // ignore: valid_regexps
                      String? url;
                      var date;
                      (snapshot.data!).length < 1
                          ? 'url'
                          : url = snapshot.data![index].imageUrl_at!
                              .replaceAll('public_html/', '');
                      (snapshot.data!).length < 1
                          ? 1
                          : date = snapshot.data![index].dateTime_at!;
                      return (snapshot.data!).length < 1
                          ? const Center(child: Text('No Blogs uploaded'))
                          : Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 30),
                              width: widget.width != null
                                  ? widget.width
                                  : _width >= 700
                                      ? 700
                                      : _width,
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 10,
                                    shadowColor: Colors.black87,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(5)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: widget.width,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 0.2,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: Text(
                                                  snapshot
                                                      .data![index].title_at!,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    // AppColors.text,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        _width > 700 ? 23 : 15,
                                                  ),
                                                ),
                                              ),

                                              Image(
                                                image: NetworkImage(url!,
                                                    scale: 1.0),
                                                width: widget.width,
                                                height: _width >= 500
                                                    ? 350
                                                    : _width - 150,
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  //   border:Border.all(
                                                  //     width: 0.2,
                                                  //     color: Colors.black
                                                  // ),
                                                  color: Colors.black12,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                height: 18,
                                                width: widget.width,
                                                margin: const EdgeInsets.only(
                                                  bottom: 3,
                                                ),
                                                child: Text(
                                                  '  Uploaded by ${snapshot.data![index].uploader_at!} on ${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}  ${date.substring(8, 10)}:${date.substring(10, 12)}:${date.substring(12, 14)}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          _width > 700 ? 12 : 9,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Container(
                                                width: widget.width,
                                                padding: const EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5),
                                                child: ReadMoreText(
                                                  snapshot
                                                      .data![index].post_at!,
                                                  style: TextStyle(
                                                    fontSize:
                                                        _width > 700 ? 16 : 12,
                                                  ),
                                                  trimLines: 2,
                                                  colorClickableText:
                                                      AppColors.gradient[0],
                                                  trimMode: TrimMode.Length,
                                                  trimCollapsedText:
                                                      '\nSHOW MORE...',
                                                  trimExpandedText:
                                                      '\nSHOW LESS...',
                                                ),
                                              ),
                                              // ignore: sized_box_for_whitespace
                                              Container(
                                                width: widget.width,
                                                child: Divider(
                                                  height: 14,
                                                  color: AppColors.gradient[0],
                                                ),
                                              ),

                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 5,
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
                                                  gradient: widget.isAdmin
                                                      ? LinearGradient(
                                                          begin: Alignment
                                                              .topRight,
                                                          end:
                                                              Alignment.topLeft,
                                                          colors: [
                                                            AppColors
                                                                .gradient[0],
                                                            AppColors
                                                                .gradient[1],
                                                          ],
                                                        )
                                                      : null,
                                                ),
                                                height: widget.isAdmin ? 40 : 1,
                                                width: widget.width,
                                                child: widget.isAdmin
                                                    ? Row(
                                                        children: [
                                                          const Spacer(),
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                Connect.appAlert(
                                                                    context,
                                                                    title:
                                                                        'Deleting Post',
                                                                    content:
                                                                        const Text(
                                                                            'Are you sure to delete this Post?'),
                                                                    okPressed:
                                                                        () async {
                                                                  await Connect.delete(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .id,
                                                                      table:
                                                                          'blog');
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(
                                                                      () {});
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                // size: 30,
                                                                color: AppColors
                                                                    .text,
                                                              )),
                                                          const Spacer(),
                                                          IconButton(
                                                              onPressed: () {
                                                                Connect.appDialog(
                                                                    context,
                                                                    content:
                                                                        Edit(
                                                                      popData: {
                                                                        'id': snapshot
                                                                            .data![index]
                                                                            .id!,
                                                                        'title': snapshot
                                                                            .data![index]
                                                                            .title_at!,
                                                                        'image': snapshot
                                                                            .data![index]
                                                                            .imageUrl_at!,
                                                                        'detail': snapshot
                                                                            .data![index]
                                                                            .post_at!,
                                                                      },
                                                                      type:
                                                                          'blogs',
                                                                      onPress:
                                                                          (a) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                    ),
                                                                    title:
                                                                        'Blog Update');
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .edit_outlined,
                                                                // size: 30,
                                                                color: AppColors
                                                                    .text,
                                                              )),
                                                          const Spacer(),
                                                        ],
                                                      )
                                                    : Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                    },
                    itemCount: (snapshot.data!).length < 1
                        ? 1
                        : (snapshot.data)!.length,
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(child: LinearProgressIndicator());
                } else {
                  return const Center(child: LinearProgressIndicator());
                }
              },
              future: getData(),
            ),
          );
  }
}

class BlogModel {
  final int? id;
  final String? title_at;
  final String? post_at;
  final String? uploader_at;
  final String? imageUrl_at;
  final String? dateTime_at;
  BlogModel(
      {this.id,
      this.uploader_at,
      this.title_at,
      this.post_at,
      this.dateTime_at,
      this.imageUrl_at});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as int?,
      title_at: json['title_at'] as String?,
      post_at: json['post_at'] as String?,
      uploader_at: json['uploader_at'] as String?,
      imageUrl_at: json['imageUrl_at'] as String?,
      dateTime_at: json['dateTime_at'] as String?,
    );
  }
}
