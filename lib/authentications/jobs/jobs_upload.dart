import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/textfield.dart';

class JobsUpload extends StatefulWidget {
  @override
  _JobsUploadState createState() => _JobsUploadState();
}

class _JobsUploadState extends State<JobsUpload> {
  final _uploadFormKey = GlobalKey<FormState>();
  ScrollController _controller = ScrollController();
  var _width, _height, extension, _title, _detail, _from, _region, _category;

  var currentFileExtension;
  var image;
  Uint8List? imagebytes;
  FilePickerCross? file;
  String? imagePath;

  Future uploadJob() async {
    String url = '${AppUrl.temp}job_upload';
    var res = await http.post(
      Uri.parse(url),
      body: {
        'title': _title,
        'from': _from,
        'date': DateTime.now()
            .toIso8601String()
            .replaceAll('-', '')
            .replaceAll('T', '')
            .replaceAll(':', '')
            .replaceAll('.', ''),
        'category': _category,
        'region': _region,
        'detail': _detail,
      },
    );
    print(res.statusCode);
    return res.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    // print();
    return Container(
      width: _width > 800 ? 800 : _width,
      height: _height,
      child: Scrollbar(
        thickness: 10,
        thumbVisibility: true,
        controller: _controller,
        child: SingleChildScrollView(
          child: Form(
            key: _uploadFormKey,
            child: Container(
              width: _width > 800 ? 800 : _width,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Upload Jobs', style: TextStyle(fontSize: 30)),
                  ),
                  Container(
                    width: _width > 800 ? 800 : _width,
                    child: TheTextField(
                      hintText: 'Job Title',
                      onChange: (a) => setState(() {
                        _title = a;
                      }),
                    ),
                  ),
                  Container(
                    width: _width > 800 ? 800 : _width,
                    child: TheTextField(
                      hintText: 'Poster Email',
                      onChange: (a) => setState(() {
                        _from = a;
                      }),
                    ),
                  ),
                  Container(
                    width: _width > 800 ? 800 : _width,
                    child: TheTextField(
                      hintText: 'Category',
                      onChange: (a) => setState(() {
                        _category = a;
                      }),
                    ),
                  ),
                  Container(
                    width: _width > 800 ? 800 : _width,
                    child: TheTextField(
                      hintText: 'Region',
                      onChange: (a) => setState(() {
                        _region = a;
                      }),
                    ),
                  ),
                  Container(
                    width: _width > 800 ? 800 : _width,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        color: AppColors.card,
                        elevation: 10,
                        child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Writing job details...',
                            labelText: 'Job details...',
                            border: const UnderlineInputBorder(),
                            alignLabelWithHint: true,
                            hoverColor: AppColors.gradient[0].withOpacity(0.1),
                            focusColor: AppColors.primary,
                            fillColor: AppColors.gradient[0].withOpacity(0.1),
                          ),
                          minLines: 6,
                          showCursor: true,
                          keyboardType: TextInputType.multiline,
                          onChanged: (a) => setState(() {
                            _detail = a;
                          }),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                      color: AppColors.gradient[0],
                      onPressed: () async {
                        if (_uploadFormKey.currentState!.validate()) {
                          await uploadJob().then((value) {
                            if (value == 200) {
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        child: const Center(
                          child: Text(
                            'Upload',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
