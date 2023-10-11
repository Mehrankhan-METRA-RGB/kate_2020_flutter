import 'dart:html' as html;
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as pth;

class BlogUpload extends StatefulWidget {
  BlogUpload({this.uploader, this.isSeparate = false});
  final String? uploader;
  final bool isSeparate;
  @override
  _BlogUploadState createState() => _BlogUploadState();
}

class _BlogUploadState extends State<BlogUpload> {
  final _uploadFormKey = GlobalKey<FormState>();
  ScrollController _controller = ScrollController();
  var _width, _height, extension, _title, _post;
  var currentFileExtension;
  var image;
  Uint8List? imagebytes;
  FilePickerCross? file;
  var imagePath;
  String? _fileName;
  Image? _imageWidget;
  Future pickIamgeWeb() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String? mimeType = mime(pth.basename(mediaData.fileName!));
    html.File mediaFile =
        html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});
    var path;
    setState(() {
      // imagePath=mediaData.;
      imagebytes = mediaData.data;
      _fileName = mediaData.fileName;
      var data = _fileName!.split('.');
      extension = '.${data[data.length - 1]}';
    });
    // print('path:$imagePath');
  }

  Future UploadData() async {
    var dio = Dio();
    var formData = FormData.fromMap({
      'title': _title,
      'post': _post,
      'uploaded_by': widget.uploader!,
      'date': '${DateTime.now()}',
      'file': await MultipartFile.fromFile(
        imagePath!,
        filename:
            '${Random().nextInt(990000000)}_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().millisecond}_kate_blog_image$extension',
        contentType: MediaType("image", "png"),
      ),
    });
    // var response = await dio.post('/info', data: formData);

    var response = await dio.post(
      'http://localhost:8080/blog_upload',
      data: formData,
      onSendProgress: (int sent, int total) {
        print('sent:$sent | Total:$total');
      },
    );
  }

  Future uploadData() async {
    var request =
        http.MultipartRequest('POST', Uri.parse('${AppUrl.temp}blog_upload'));
    request.files.add(await http.MultipartFile.fromPath(
      'blog_image',
      imagePath!,
      filename:
          '${Random().nextInt(990000000)}_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().millisecond}_kate_blog_image$extension',
    ));

    request.fields['title'] = _title;
    request.fields['post'] = _post;
    request.fields['uploaded_by'] = widget.uploader!;
    request.fields['date'] = '${DateTime.now()}';

    var res = await request.send();
    print(res.statusCode);
    return res.statusCode;
  }

  Future makePostRequest() async {
    String url = '${AppUrl.temp}blog_upload';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    List<int> list = imagebytes!.cast();
    request.files.add(http.MultipartFile.fromBytes('file', list,
        filename:
            '${Random().nextInt(990000000)}_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}_kate_blog_image$extension'));

    request.fields['title'] = _title;
    request.fields['post'] = _post;
    request.fields['uploaded_by'] = widget.uploader!;
    request.fields['date'] = '${DateTime.now()}'
        .replaceAll('-', '')
        .replaceAll('T', '')
        .replaceAll(':', '')
        .replaceAll('.', '');
    // Now we can make this call

    var response = await request.send();

    print(response.statusCode);
    return response.statusCode;
  }

  Future pickImage() async {
// show a dialog to open a file
    file = await FilePickerCross.importFromStorage(
        type: FileTypeCross
            .image, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            'png,jpg,jpeg' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
        );
    setState(() {
      if (file!.fileName!.contains(file!.fileExtension.substring(0, 3))) {
        extension = '.${file!.fileExtension.substring(0, 3)}';
      } else if (file!.fileName!
          .contains(file!.fileExtension.substring(4, 7))) {
        extension = '.${file!.fileExtension.substring(4, 7)}';
      } else if (file!.fileName!
          .contains(file!.fileExtension.substring(8, 12))) {
        extension = '.${file!.fileExtension.substring(8, 12)}';
      }
      print(extension);
      imagePath = file!.path;
      print(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return widget.isSeparate
        ? Scaffold(
            // appBar: AppBar(),
            body: Container(
              width: _width > 800 ? 800 : _width,
              height: _height,
              child: uploadWiget(),
            ),
          )
        : uploadWiget();
  }

  Widget uploadWiget() {
    return Scrollbar(
      controller: _controller,
      thickness: 10,
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Form(
          key: _uploadFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: Stack(
                    children: [
                      imagebytes != null
                          ? Image.memory(
                              imagebytes!,
                              width: _width > 800 ? 800 : _width,
                              height: _width > 800 ? 300 : 200,
                              fit: BoxFit.fitHeight,
                            )
                          : Image.asset(
                              'assets/logos/kate_logo.png',
                              width: _width > 800 ? 800 : _width,
                              height: _width > 800 ? 300 : 200,
                            ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: IconButton(
                          color: AppColors.gradient[0],
                          alignment: Alignment.center,
                          onPressed: () async {
                            await pickIamgeWeb();

                            // currentFileExtension = [
                            //   "jpg",
                            //   'jpeg',
                            //   'png',
                            //   'gif'
                            // ];
                            // image = await ImagePicker()
                            //     .pickImage(source: ImageSource.gallery);
                            // imagebytes = await image.readAsBytes();
                            //

                            setState(() {});
                            // await pickImage();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: _width > 800 ? 35 : 25,
                            color: AppColors.gradient[0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: _width > 800 ? 800 : _width,
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
                          _title = a;
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Card(
                      elevation: 10,
                      color: AppColors.card,
                      child: TextFormField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Writing Blog...',
                          labelText: 'Blog Text...',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          alignLabelWithHint: true,
                          hoverColor: AppColors.gradient[0].withOpacity(0.1),
                          focusColor: AppColors.primary,
                          fillColor: AppColors.gradient[0].withOpacity(0.1),
                        ),
                        minLines: 6,
                        showCursor: true,
                        keyboardType: TextInputType.multiline,
                        onChanged: (a) => setState(() {
                          _post = a;
                        }),
                      ),
                    ),
                    MaterialButton(
                      color: AppColors.gradient[0],
                      onPressed: () {
                        if (_uploadFormKey.currentState!.validate()) {
                          makePostRequest().then((value) {
                            if (value == 200) {
                              Navigator.pop(context);
                            }
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
        ),
      ),
    );
  }
}
