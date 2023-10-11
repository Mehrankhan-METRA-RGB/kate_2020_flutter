import 'dart:convert';
import 'dart:html' as html;

import 'package:kate/authentications/blog/news_blog.dart';
import 'package:kate/constants/urls.dart';
import 'package:mime_type/mime_type.dart';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path/path.dart' as pth;
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/widgets/footer.dart';
import 'package:http/http.dart' as http;

class LibraryUpload extends StatefulWidget {
  LibraryUpload({this.uploader = 'null', this.isSeparate = false});
  final String uploader;
  final bool isSeparate;
  @override
  _LibraryUploadState createState() => _LibraryUploadState();
}

class _LibraryUploadState extends State<LibraryUpload> {
  var extension, _category;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  final _uploadFormKey = GlobalKey<FormState>();
  ScrollController _controller = ScrollController();
  var _width, _height, _detail;
  var currentFileExtension;
  var image;
  Uint8List? fileBytes;
  FilePickerCross? file;
  var filePath;
  String? _nameFile;
  Image? _imageWidget;

  Future pickFile() async {
// show a dialog to open a file
    file = await FilePickerCross.importFromStorage(
        type: FileTypeCross
            .custom, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            'pptx,ppt,odp,docx,doc,xlsx,xls,pdf' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
        );

    List _extList = file!.fileExtension.split(',');
    setState(() {
      if (file!.fileName!.contains(_extList[0])) {
        extension = '.${_extList[0]}';
      } else if (file!.fileName!.contains(_extList[1])) {
        extension = '.${_extList[1]}';
      } else if (file!.fileName!.contains(_extList[2])) {
        extension = '.${_extList[2]}';
      } else if (file!.fileName!.contains(_extList[3])) {
        extension = '.${_extList[3]}';
      } else if (file!.fileName!.contains(_extList[4])) {
        extension = '.${_extList[4]}';
      } else if (file!.fileName!.contains(_extList[5])) {
        extension = '.${_extList[5]}';
      } else if (file!.fileName!.contains(_extList[6])) {
        extension = '.${_extList[6]}';
      } else if (file!.fileName!.contains(_extList[7])) {
        extension = '.${_extList[7]}';
      }
      _nameController.text = file!.fileName!.split('.')[0];
      // print(extension);
      fileBytes = file!.toUint8List();
      // print(filePath);
      // print(
      //     '${_nameController.text.replaceAll(' ', '+')}_kate_${DateTime.now().toIso8601String().replaceAll('-', '').replaceAll('T', '').replaceAll(':', '').replaceAll('.', '')}$extension');
    });
  }

  Future makePostRequest() async {
    var url = '${AppUrl.temp}library_upload';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    List<int> list = fileBytes!.cast();
    request.files.add((http.MultipartFile.fromBytes('library', list,
        filename:
            '${_nameController.text.replaceAll(' ', '+')}_kate_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}$extension')));
    request.fields['detail'] = _detail;
    request.fields['uploader'] = widget.uploader;
    request.fields['category'] = _category;
    request.fields['extension'] = extension;
    var response = await request.send();
    print(response.statusCode);
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return widget.isSeparate
        ? Scaffold(
            // appBar: AppBar(),
            body: uploadWiget(),
          )
        : uploadWiget();
  }

  Widget uploadWiget() {
    return Container(
      width: _width > 800 ? 800 : _width,
      height: _height,
      child: SingleChildScrollView(
          child: Form(
        key: _uploadFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 29,
            ),
            Card(
              elevation: 10,
              color: AppColors.card,
              child: Container(
                width: _width > 800 ? 800 : _width,
                margin: const EdgeInsets.only(top: 0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppColors.card),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'File Name...',
                          labelText: 'File Name...',
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                          contentPadding:
                              const EdgeInsets.only(left: 15, bottom: 9),
                          hoverColor: AppColors.card.withOpacity(0.6),
                          focusColor: AppColors.card,
                          fillColor: AppColors.card,
                        ),
                        // minLines: 1,
                        showCursor: true,
                        keyboardType: TextInputType.text,
                        onChanged: (a) => setState(() {
                          // _nameController.text = a;
                        }),
                      ),
                    ),
                    IconButton(
                      color: AppColors.gradient[0],
                      alignment: Alignment.center,
                      onPressed: () async {
                        await pickFile();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.attach_file,
                        size: _width > 800 ? 28 : 20,
                        color: AppColors.gradient[0],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: AppColors.card,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  width: _width > 800 ? 800 : _width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    child: DropdownButton(
                      isExpanded: true,
                      iconSize: 25,
                      elevation: 10,
                      // icon: Icon(Icons.font_download),
                      hint: const Text('Choose Category'),
                      dropdownColor: Colors.white,
                      value: _category,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Book'),
                          value: 'book',
                        ),
                        DropdownMenuItem(
                          child: Text('Document'),
                          value: 'document',
                        ),
                      ],

                      onChanged: (Object? a) {
                        setState(() {
                          _category = a.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: _width > 800 ? 800 : _width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
              // color: AppColors.gradient[1].withOpacity(0.9),
              child: Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  Card(
                    elevation: 10,
                    color: AppColors.card,
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Writing Title...',
                        labelText: 'Title...',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                        alignLabelWithHint: true,
                        hoverColor: AppColors.card.withOpacity(0.6),
                        focusColor: AppColors.card,
                        fillColor: AppColors.card,
                      ),
                      minLines: 1,
                      showCursor: true,
                      keyboardType: TextInputType.multiline,
                      onChanged: (a) => setState(() {
                        _detail = a;
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  MaterialButton(
                    color: AppColors.gradient[0],
                    onPressed: () {
                      if (_uploadFormKey.currentState!.validate()) {
                        makePostRequest().then((value) {
                          setState(() {
                            Navigator.pop(context);
                          });
                        });
                      }
                    },
                    child: Container(
                      width: 150,
                      margin: EdgeInsets.all(4),
                      child: const Center(
                        child: Text(
                          'Upload',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
