import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/textfield.dart';

class TestimonialsUpload extends StatefulWidget {
  @override
  _TestimonialsUploadState createState() => _TestimonialsUploadState();
}

class _TestimonialsUploadState extends State<TestimonialsUpload> {
  final _uploadFormKey = GlobalKey<FormState>();
  ScrollController _controller = ScrollController();
  var _width, _currentCompany, _detail, _name, _height;

  var currentFileExtension;
  var image;
  Uint8List? imagebytes;
  FilePickerCross? file;
  String? imagePath;

  Future uploadTestimonial() async {
    String url = '${AppUrl.temp}testimonial_upload';
    var res = await http.post(Uri.parse(url), body: {
      'currentCompany': _currentCompany,
      'detail': _detail,
      'date': DateTime.now()
          .toIso8601String()
          .replaceAll('-', '')
          .replaceAll('T', '')
          .replaceAll(':', '')
          .replaceAll('.', ''),
      'name': _name,
    });
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
        controller: _controller,
        thickness: 10,
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Form(
              key: _uploadFormKey,
              child: Container(
                width: _width > 800 ? 800 : _width,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Testimonial Upload',
                          style: TextStyle(fontSize: 30)),
                    ),
                    Container(
                      width: _width > 800 ? 800 : _width,
                      child: TheTextField(
                        hintText: 'Role',
                        onChange: (a) => setState(() {
                          _currentCompany = a;
                        }),
                      ),
                    ),
                    Container(
                      width: _width > 800 ? 800 : _width,
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        color: AppColors.card,
                        elevation: 10,
                        child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Writing testimonial details...',
                            labelText: 'Testimonial details...',
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
                    Container(
                      width: _width > 800 ? 800 : _width,
                      child: TheTextField(
                        hintText: 'Customer Name',
                        onChange: (a) => setState(() {
                          _name = a;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MaterialButton(
                        color: AppColors.gradient[0],
                        onPressed: () async {
                          if (_uploadFormKey.currentState!.validate()) {
                            await uploadTestimonial().then((value) {
                              if (value == 200) {
                                Navigator.pop(context);
                              }
                            });
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Blog_News(),));
                          }
                        },
                        child: Container(
                          width: 100,
                          child: const Center(
                            child: Text(
                              ' Upload ',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
