import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kate/adminPanel/backend.dart';
import 'package:kate/authentications/course_registeration.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/data.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/textfield.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Certificate extends StatefulWidget {
  Certificate(this.filter);
  final filter;
  @override
  _CertificateState createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  final pdf = pw.Document();
  var val = 0;
  var anchor;
  ScrollController _scrollController = ScrollController();

  final signUpkey = GlobalKey<FormState>();
  Future<List<StdModel>> getData() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/students',
    );
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    List<StdModel> unsortedata =
        decode.map((user) => StdModel.fromJson(user)).toList();
    List<StdModel> list = [];
    for (var date in unsortedata) {
      if (date.course == widget.filter) {
        list.add(date);
      }
    }
    list.sort((a, b) => -a.init_date!.compareTo(b.init_date!));
    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  var _height, _width;
  var headingSize;
  var valueSize;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    headingSize = _width >= 500 ? 14 : 12;
    valueSize = _width >= 500 ? 13 : 10;

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
            child: Column(
              children: [
                const Text(
                  'Registered Students',
                  style: TextStyle(fontSize: 25),
                ),
                FutureBuilder<List<StdModel>?>(
                  builder: (context, snapshot) {
                    // // print(snapshot.data);
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var date;
                          (snapshot.data!).length < 1
                              ? date = 1
                              : date = snapshot.data![index].init_date!;

                          return (snapshot.data!).length < 1
                              ? Center(
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
                                    elevation: 5,
                                    color: AppColors.card,
                                    child: ExpansionTile(
                                      // initiallyExpanded: true,
                                      textColor: AppColors.textBlack,
                                      childrenPadding: const EdgeInsets.only(
                                          bottom: 15,
                                          left: 15,
                                          right: 15,
                                          top: 1),
                                      tilePadding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      expandedAlignment: Alignment.centerLeft,
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
                                                    fontSize:
                                                        _width < 800 ? 8 : 11),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              snapshot.data![index].name!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      _width >= 500 ? 16 : 13),
                                            ),
                                            Spacer(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                createPDF(
                                                  verification: snapshot
                                                      .data![index]
                                                      .verificationNo!,
                                                  registration: snapshot
                                                      .data![index]
                                                      .registrationNo!,
                                                  name: snapshot
                                                      .data![index].name!,
                                                  date: snapshot
                                                      .data![index].init_date!,
                                                  course: snapshot
                                                      .data![index].course!,
                                                );
                                              },
                                              color: AppColors.primary,
                                              child: const Text(
                                                'Generate',
                                                style: TextStyle(
                                                    color: AppColors.text,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11),
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
                                                fontSize:
                                                    _width >= 500 ? 11 : 9),
                                          ),
                                          Spacer(),
                                          Text(
                                            'RegNo: ${snapshot.data![index].registrationNo!}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    _width >= 500 ? 10 : 8),
                                          ),
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
                                                    fontSize: valueSize),
                                              ),
                                            ],
                                            text: 'Initial Date: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: headingSize),
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
                                                    fontSize: valueSize),
                                              ),
                                            ],
                                            text: 'Last Date: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: headingSize),
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
                                                    snapshot.data![index].nic!,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: valueSize),
                                              ),
                                            ],
                                            text: 'NIC: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: headingSize),
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
                                                        .data![index].phone!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: valueSize),
                                                  ),
                                                ],
                                                text: 'Phone: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: headingSize),
                                              ),
                                            ),
                                            const Spacer(),
                                            MaterialButton(
                                              onPressed: () {
                                                Connect.whatsApp(
                                                    phone: snapshot
                                                        .data![index].phone!,
                                                    text:
                                                        '''Mr/Ms ${snapshot.data![index].name!}''');
                                              },
                                              child: Image.asset(
                                                'assets/logos/whatsapp.png',
                                                width: 21,
                                                height: 21,
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
                                                        .data![index].email!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: valueSize),
                                                  ),
                                                ],
                                                text: 'Email: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: headingSize),
                                              ),
                                            ),
                                            Spacer(),
                                            MaterialButton(
                                              onPressed: () {
                                                Connect.mail(
                                                    email: snapshot
                                                        .data![index].email!,
                                                    text:
                                                        '''Mr/Ms ${snapshot.data![index].name!}''');
                                              },
                                              color: AppColors.primary,
                                              child: Text(
                                                'Mail',
                                                style: TextStyle(
                                                    color: AppColors.text,
                                                    fontSize: valueSize),
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
                                                text: snapshot.data![index]
                                                    .verificationNo,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: valueSize),
                                              ),
                                            ],
                                            text: 'Verification Code: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: headingSize),
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
                                                    .data![index].gender,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: valueSize),
                                              ),
                                            ],
                                            text: 'Gender: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: headingSize),
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
                                                    fontSize: valueSize),
                                              ),
                                            ],
                                            text: 'Course: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: headingSize),
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
                                                    fontSize: valueSize),
                                              ),
                                            ],
                                            text: 'Mode of Training: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: headingSize),
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
                                                    text:
                                                        '${snapshot.data![index].amountPaid} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: valueSize),
                                                  ),
                                                ],
                                                text: 'Paid : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: headingSize),
                                              ),
                                            ),
                                            Spacer(),
                                            MaterialButton(
                                                onPressed: () {
                                                  pay(snapshot.data![index].id);
                                                },
                                                child: const Text('Pay More')),
                                          ],
                                        ),
                                        Divider(
                                          color: AppColors.gradient[0]
                                              .withOpacity(0.3),
                                          thickness: 0.5,
                                        ),
                                        Center(
                                          child: MaterialButton(
                                            onPressed: () {
                                              Connect.appAlert(context,
                                                  title: 'Deleting Student',
                                                  content: const Text(
                                                      'Are you sure to delete this Student?'),
                                                  okPressed: () async {
                                                await Connect.delete(
                                                    snapshot.data![index].id,
                                                    table: 'student');
                                                setState(() {});
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: AppColors.gradient[0]
                                              .withOpacity(0.3),
                                          thickness: 0.5,
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
                      // return const Center(child:  LinearProgressIndicator();
                      return const Center(child: LinearProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: LinearProgressIndicator());
                    } else {
                      return const Center(child: LinearProgressIndicator());
                    }
                  },
                  future: getData(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Connect.appDialog(context,
              scroll: false,
              title: 'Register Student',
              content: RegisterCourse());
        },
      ),
    );
  }

  Future createPDF({verification, registration, name, date, course}) async {
    Connect.snackBar(context,
        msg: Container(
          height: 100,
          child: Column(
            children: [
              Container(
                  width: _width,
                  child: const Text(
                    "The certificate is generating on background please wait for Dialog Box to appear before generating another certificate",
                    style: TextStyle(color: AppColors.text),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const CircularProgressIndicator(
                    color: Colors.red,
                  )),
            ],
          ),
        ));
    var dateindex = int.parse(date.toString().substring(4, 6));
    // print(date);
    var month = Data().months[dateindex - 1];

    // print(month);
    // print('1');
    var formatedDate =
        '${date.toString().substring(6, 7)} $month ${date.toString().substring(0, 4)}';

    var backgroung = pw.MemoryImage(
      (await rootBundle.load('assets/logos/certificate_1.png'))
          .buffer
          .asUint8List(),
    );
    // var watermark = pw.MemoryImage(
    //   (await rootBundle.load('assets/logos/kate_logo.png'))
    //       .buffer
    //       .asUint8List(),
    // );
    var organizer = pw.MemoryImage(
      (await rootBundle.load('assets/logos/sign_organizer.png'))
          .buffer
          .asUint8List(),
    );
    var trainer = pw.MemoryImage(
      (await rootBundle.load('assets/logos/sign_trainer.png'))
          .buffer
          .asUint8List(),
    );
    var logo_kate = pw.MemoryImage(
      (await rootBundle.load('assets/logos/ct_logo.png')).buffer.asUint8List(),
    );
    var maintextFont = await rootBundle.load("fonts/Almarai-Regular.ttf");
    var upperLogo = await rootBundle.load("fonts/Cinzel-Bold.ttf");
    await rootBundle
        .load("fonts/DancingScript-Regular.ttf")
        .then((fonts) {
          pdf.addPage(
            pw.Page(
              margin: pw.EdgeInsets.zero,
              pageFormat: PdfPageFormat.a4.landscape,
              build: (pw.Context context1) => pw.Stack(
                  alignment: pw.Alignment.center,
                  // overflow: pw.Overflow.clip,
                  children: [
                    // pw.Watermark(child:pw.Image(watermark, height: 200,width: 110,) ),
                    // pw.Container(width:PdfPageFormat.a4.landscape.width,height: PdfPageFormat.a4.landscape.height,color: PdfColors.white.shade(20), ),

                    pw.Image(backgroung, fit: pw.BoxFit.cover),

                    pw.Positioned(
                      bottom: 15,
                      child: pw.Image(logo_kate, width: 160, height: 360),
                    ),
                    pw.Positioned(
                      top: 90,
                      child: pw.Container(
                          padding: pw.EdgeInsets.symmetric(horizontal: 50),
                          height: 60,
                          width: PdfPageFormat.a4.landscape.width,
                          // color:  PdfColors.red,
                          child: pw.Row(
                            children: [
                              pw.Container(
                                  width: 150,
                                  child: pw.Column(children: [
                                    pw.Text('''Verification: $verification''',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          // color: PdfColors.indigo,
                                          fontStyle: pw.FontStyle.normal,
                                          font: pw.Font.ttf(maintextFont),
                                        )),
                                    pw.Divider(),

                                    ///WEB URL
                                    pw.UrlLink(
                                        child: pw.Text('''kateintl.com''',
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                              color: PdfColors.indigo,
                                              fontStyle: pw.FontStyle.normal,
                                              font: pw.Font.ttf(maintextFont),
                                            )),
                                        destination: 'https://kateintl.com'),
                                  ])),
                              pw.Spacer(),
                              pw.Container(
                                  width: 150,
                                  child: pw.Column(children: [
                                    pw.Text('''RegNo: $registration''',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          // color: PdfColors.indigo,
                                          fontStyle: pw.FontStyle.normal,
                                          font: pw.Font.ttf(maintextFont),
                                        )),
                                    pw.Divider(),
                                  ])),
                            ],
                          )),
                    ),
                    pw.Positioned(
                      top: 42,

                      child: pw.RichText(
                          text: pw.TextSpan(children: [
                            pw.TextSpan(
                                text: 'KATE\n',
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  color: PdfColors.orange,
                                  fontWeight: pw.FontWeight.bold,
                                  fontStyle: pw.FontStyle.normal,
                                  font: pw.Font.ttf(upperLogo),
                                )),
                            pw.TextSpan(
                                text: 'international',
                                style: pw.TextStyle(
                                  fontSize: 11,
                                  color: PdfColors.orange,
                                  fontStyle: pw.FontStyle.normal,
                                  font: pw.Font.ttf(fonts),
                                )),
                          ]),
                          textAlign: pw.TextAlign.center),
                      // pw.RichText(text:const pw.TextSpan(text:'''K A T E International''', ),)
                    ),
                    pw.Positioned(
                      top: 175,

                      child: pw.Text('''Certification of participation''',
                          style: pw.TextStyle(
                            fontSize: 23,
                            color: PdfColors.indigo,
                            fontStyle: pw.FontStyle.normal,
                            font: pw.Font.ttf(fonts),
                          )),
                      // pw.RichText(text:const pw.TextSpan(text:'''K A T E International''', ),)
                    ),
                    pw.Positioned(
                      top: 230,

                      child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                pw.TextSpan(
                                    text: '''This certificate is award to\n''',
                                    style: pw.TextStyle(
                                      // color: PdfColors.indigo,
                                      fontWeight: pw.FontWeight.bold,
                                      fontStyle: pw.FontStyle.normal,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text: '''Mr/Ms $name\n''',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      color: PdfColors.indigo,
                                      fontStyle: pw.FontStyle.normal,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text:
                                        '''on participation of session on\n''',
                                    style: pw.TextStyle(
                                      // color: PdfColors.indigo,
                                      fontWeight: pw.FontWeight.bold,

                                      fontStyle: pw.FontStyle.normal,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text: '''“ $course ”\n''',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      // color: PdfColors.indigo,
                                      fontStyle: pw.FontStyle.italic,
                                      fontWeight: pw.FontWeight.bold,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text: '''on ''',
                                    style: pw.TextStyle(
                                      // color: PdfColors.indigo,
                                      fontStyle: pw.FontStyle.normal,
                                      fontWeight: pw.FontWeight.bold,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text: '''$formatedDate''',
                                    style: pw.TextStyle(
                                      color: PdfColors.indigo,
                                      fontStyle: pw.FontStyle.normal,
                                      fontWeight: pw.FontWeight.bold,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text: ''' organized by\n''',
                                    style: pw.TextStyle(
                                      // color: PdfColors.indigo,
                                      fontStyle: pw.FontStyle.normal,
                                      fontWeight: pw.FontWeight.bold,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text: '''KATE International ''',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      color: PdfColors.indigo,
                                      fontStyle: pw.FontStyle.normal,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                                pw.TextSpan(
                                    text: ''' PVT LMT''',
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      // color: PdfColors.indigo,
                                      fontStyle: pw.FontStyle.normal,
                                      font: pw.Font.ttf(maintextFont),
                                    )),
                              ],
                              style: const pw.TextStyle(
                                lineSpacing: 10,
                                fontSize: 14,
                              ),
                            ),
                            textAlign: pw.TextAlign.center),

//
                      ),
                      // pw.RichText(text:const pw.TextSpan(text:'''K A T E International''', ),)
                    ),
                    pw.Positioned(
                      bottom: 60,
                      child: pw.Container(
                          padding: pw.EdgeInsets.symmetric(horizontal: 70),
                          height: 90,
                          width: PdfPageFormat.a4.landscape.width,
                          // color:  PdfColors.red,
                          child: pw.Row(
                            children: [
                              pw.Container(
                                  width: 150,
                                  child: pw.Column(children: [
                                    pw.Image(trainer,
                                        fit: pw.BoxFit.fill,
                                        width: 100,
                                        height: 40),
                                    pw.Divider(),
                                    pw.Text('''HSE Trainer:
Eng Shahan Bacha ''',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          // color: PdfColors.indigo,
                                          fontStyle: pw.FontStyle.normal,
                                          font: pw.Font.ttf(maintextFont),
                                        )),
                                  ])),
                              pw.Spacer(),
                              pw.Container(
                                  width: 150,
                                  child: pw.Column(children: [
                                    pw.Image(organizer,
                                        fit: pw.BoxFit.fill,
                                        width: 100,
                                        height: 40),
                                    pw.Divider(),
                                    pw.Text('''Training Organiser:
Eng Farooq khan''',
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          // color: PdfColors.indigo,
                                          fontStyle: pw.FontStyle.normal,
                                          font: pw.Font.ttf(maintextFont),
                                        )),
                                  ])),
                            ],
                          )),
                    ),
                    pw.Positioned(
                        bottom: 2,
                        child: pw.Container(
                          alignment: pw.Alignment.center,
                          width: PdfPageFormat.a4.landscape.width,
                          height: 10,
                          child: pw.Text(
                              '''Certification can be validated through the KATE website (kateintl.com) ''',
                              style: pw.TextStyle(
                                fontSize: 9,
                                color: PdfColors.orange,
                                fontStyle: pw.FontStyle.normal,
                                font: pw.Font.ttf(maintextFont),
                              )),
                        )),
                  ]),
            ),
          );

          // print('2');
        })
        .whenComplete(() async {
          // print('3');

          Uint8List pdfInBytes = await pdf.save();
          final blob = html.Blob([pdfInBytes], 'application/pdf');
          final url = html.Url.createObjectUrlFromBlob(blob);
          setState(() {
            anchor = html.document.createElement('a') as html.AnchorElement
              ..href = url
              ..style.display = 'none'
              ..download = '${name}_$registration.pdf';
            html.document.body!.children.add(anchor);
            // print('4');
            val = 4;
          });
        })
        .whenComplete(() => anchor.click())
        .whenComplete(() => Connect.appAlert(context,
                content: const Text('download will begins shortly'),
                title: 'Downloading...', okPressed: () {
              Navigator.pop(context);
            }));
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

  pay(id) {
    var payment;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Payment',
            ),
            content: Form(
              key: signUpkey,
              child: Container(
                width: _width >= 800 ? 800 : _width,
                height: 90,
                child: TheTextField(
                  hintText: 'Pay Fee',
                  onChange: (a) => setState(() {
                    payment = a;
                  }),
                ),
              ),
            ),
            actions: [
              MaterialButton(
                color: AppColors.card,
                onPressed: () async {
                  if (signUpkey.currentState!.validate()) {
                    var res = await http
                        .post(Uri.parse("${AppUrl.temp}student/pay"), body: {
                      "paid": payment.toString(),
                      'id': id.toString()
                    });

                    // print(res.statusCode);
                  }
                  Navigator.pop(context);
                },
                child: Text('add', style: TextStyle(color: AppColors.primary)),
              )
            ],
          );
        });
  }
}

class StdModel {
  final int? id;
  final String? name;
  final String? address;
  final String? init_date;
  final String? completion_date;
  final String? nic;
  final String? postalcode;
  final String? phone;
  final String? email;
  final String? nationality;
  final String? gender;
  final String? modeOfTraining;
  final String? locationOfTrainingCenter;
  final String? course;
  final String? about;
  final String? verificationNo;
  final String? registrationNo;
  final String? billDetails;
  final String? amountPaid;
  final String? totalCourseAmnt;
  StdModel(
      {this.init_date,
      this.completion_date,
      this.name,
      this.postalcode,
      this.address,
      this.id,
      this.nic,
      this.email,
      this.phone,
      this.nationality,
      this.gender,
      this.modeOfTraining,
      this.locationOfTrainingCenter,
      this.course,
      this.about,
      this.verificationNo,
      this.registrationNo,
      this.billDetails,
      this.amountPaid,
      this.totalCourseAmnt});
  factory StdModel.fromJson(Map<String, dynamic> json) {
    return StdModel(
      id: json['id'] as int?,
      address: json['address'] as String?,
      postalcode: json['postalcode'] as String?,
      name: json['name'] as String?,
      init_date: json['initial_date'] as String?,
      completion_date: json['completion_date'] as String?,
      nic: json['nic'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      modeOfTraining: json['modeOfTraining'] as String?,
      locationOfTrainingCenter: json['training_center_loc'] as String?,
      course: json['course'] as String?,
      about: json['about'] as String?,
      verificationNo: json['verification'] as String?,
      registrationNo: json['registration'] as String?,
      billDetails: json['bill_details'] as String?,
      amountPaid: json['amount_paid'] as String?,
      totalCourseAmnt: json['total'] as String?,
    );
  }
}
