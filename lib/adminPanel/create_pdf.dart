// import 'dart:typed_data';
//
// import 'package:flutter/material.dart' as app;
// import 'package:flutter/services.dart';
// import 'package:kate/constants/colors.dart';
// import 'package:kate/constants/data.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'dart:html' as html;
// import 'backend.dart';
//
// class CreatePDF extends app.StatelessWidget {
//   final pdf = Document();
//   var val = 0;
//   var anchor;
//   var _height, _width, _headingSize, _valueSize;
//   @override
//   app.Widget build(app.BuildContext context) {
//     _height = app.MediaQuery.of(context).size.height;
//     _width = app.MediaQuery.of(context).size.width;
//     _headingSize = _width >= 500 ? 14 : 12;
//     _valueSize = _width >= 500 ? 13 : 10;
//     return app.Scaffold(
//       body: app.Container(
//           child: app.IconButton(
//         onPressed: () {
//           // createPDF(
//           //     verification: '78978-867-768',
//           //     registration: 'kate-343-34344',
//           //     date: '202008032222',
//           //     course: 'IOSH',
//           //     context: context);
//           demoPDF(context);
//         },
//         icon: app.Icon(
//           app.Icons.picture_as_pdf,
//           color: app.Colors.black54,
//         ),
//       )),
//     );
//   }
//
//   Future createPDF(
//       {verification, registration, name, date, course, context}) async {
//     Connect.snackBar(context,
//         msg: app.Container(
//           height: 100,
//           child: app.Column(
//             children: [
//               app.Container(
//                   width: _width,
//                   child: const app.Text(
//                     "The certificate is generating on background please wait for Dialog Box to appear before generating another certificate",
//                     style: app.TextStyle(color: AppColors.text),
//                   )),
//               app.Container(
//                   margin: const app.EdgeInsets.only(top: 10),
//                   child: const app.CircularProgressIndicator(
//                     color: app.Colors.red,
//                   )),
//             ],
//           ),
//         ));
//     var dateindex = int.parse(date.toString().substring(4, 6));
//     // print(date);
//     var month = Data().months[dateindex - 1];
//
//     // print(month);
//     // print('1');
//     var formatedDate =
//         '${date.toString().substring(6, 7)} $month ${date.toString().substring(0, 4)}';
//
//     var backgroung = MemoryImage(
//       (await rootBundle.load('assets/logos/certificate_1.png'))
//           .buffer
//           .asUint8List(),
//     );
//     // var watermark = MemoryImage(
//     //   (await rootBundle.load('assets/logos/kate_logo.png'))
//     //       .buffer
//     //       .asUint8List(),
//     // );
//     var organizer = MemoryImage(
//       (await rootBundle.load('assets/logos/sign_organizer.png'))
//           .buffer
//           .asUint8List(),
//     );
//     var trainer = MemoryImage(
//       (await rootBundle.load('assets/logos/sign_trainer.png'))
//           .buffer
//           .asUint8List(),
//     );
//     var logo_kate = MemoryImage(
//       (await rootBundle.load('assets/logos/ct_logo.png')).buffer.asUint8List(),
//     );
//     var maintextFont = await rootBundle.load("fonts/Almarai-Regular.ttf");
//     var upperLogo = await rootBundle.load("fonts/Cinzel-Bold.ttf");
//     await rootBundle.load("fonts/DancingScript-Regular.ttf").then((fonts) {
//       pdf.addPage(
//         Page(
//           margin: EdgeInsets.zero,
//           pageFormat: PdfPageFormat.a4.landscape,
//           build: (Context context1) => Stack(alignment: Alignment.center,
//               // overflow: Overflow.clip,
//               children: [
//                 // Watermark(child:Image(watermark, height: 200,width: 110,) ),
//                 // Container(width:PdfPageFormat.a4.landscape.width,height: PdfPageFormat.a4.landscape.height,color: PdfColors.white.shade(20), ),
//
//                 Image(backgroung, fit: BoxFit.cover),
//
//                 Positioned(
//                   bottom: 15,
//                   child: Image(logo_kate, width: 160, height: 360),
//                 ),
//                 Positioned(
//                   top: 90,
//                   child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 50),
//                       height: 60,
//                       width: PdfPageFormat.a4.landscape.width,
//                       // color:  PdfColors.red,
//                       child: Row(
//                         children: [
//                           Container(
//                               width: 150,
//                               child: Column(children: [
//                                 Text('''Verification: $verification''',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       // color: PdfColors.indigo,
//                                       fontStyle: FontStyle.normal,
//                                       font: Font.ttf(maintextFont),
//                                     )),
//                                 Divider(),
//
//                                 ///WEB URL
//                                 UrlLink(
//                                     child: Text('''kateintl.com''',
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: PdfColors.indigo,
//                                           fontStyle: FontStyle.normal,
//                                           font: Font.ttf(maintextFont),
//                                         )),
//                                     destination: 'https://kateintl.com'),
//                               ])),
//                           Spacer(),
//                           Container(
//                               width: 150,
//                               child: Column(children: [
//                                 Text('''RegNo: $registration''',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       // color: PdfColors.indigo,
//                                       fontStyle: FontStyle.normal,
//                                       font: Font.ttf(maintextFont),
//                                     )),
//                                 Divider(),
//                               ])),
//                         ],
//                       )),
//                 ),
//                 Positioned(
//                   top: 42,
//
//                   child: RichText(
//                       text: TextSpan(children: [
//                         TextSpan(
//                             text: 'KATE\n',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: PdfColors.orange,
//                               fontWeight: FontWeight.bold,
//                               fontStyle: FontStyle.normal,
//                               font: Font.ttf(upperLogo),
//                             )),
//                         TextSpan(
//                             text: 'international',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: PdfColors.orange,
//                               fontStyle: FontStyle.normal,
//                               font: Font.ttf(fonts),
//                             )),
//                       ]),
//                       textAlign: TextAlign.center),
//                   // RichText(text:const TextSpan(text:'''K A T E International''', ),)
//                 ),
//                 Positioned(
//                   top: 175,
//
//                   child: Text('''Certification of participation''',
//                       style: TextStyle(
//                         fontSize: 23,
//                         color: PdfColors.indigo,
//                         fontStyle: FontStyle.normal,
//                         font: Font.ttf(fonts),
//                       )),
//                   // RichText(text:const TextSpan(text:'''K A T E International''', ),)
//                 ),
//                 Positioned(
//                   top: 230,
//
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                                 text: '''This certificate is award to\n''',
//                                 style: TextStyle(
//                                   // color: PdfColors.indigo,
//                                   fontWeight: FontWeight.bold,
//                                   fontStyle: FontStyle.normal,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: '''Mr/Ms $name\n''',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: PdfColors.indigo,
//                                   fontStyle: FontStyle.normal,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: '''on participation of session on\n''',
//                                 style: TextStyle(
//                                   // color: PdfColors.indigo,
//                                   fontWeight: FontWeight.bold,
//
//                                   fontStyle: FontStyle.normal,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: '''“ $course ”\n''',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   // color: PdfColors.indigo,
//                                   fontStyle: FontStyle.italic,
//                                   fontWeight: FontWeight.bold,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: '''on ''',
//                                 style: TextStyle(
//                                   // color: PdfColors.indigo,
//                                   fontStyle: FontStyle.normal,
//                                   fontWeight: FontWeight.bold,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: '''$formatedDate''',
//                                 style: TextStyle(
//                                   color: PdfColors.indigo,
//                                   fontStyle: FontStyle.normal,
//                                   fontWeight: FontWeight.bold,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: ''' organized by\n''',
//                                 style: TextStyle(
//                                   // color: PdfColors.indigo,
//                                   fontStyle: FontStyle.normal,
//                                   fontWeight: FontWeight.bold,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: '''KATE International ''',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: PdfColors.indigo,
//                                   fontStyle: FontStyle.normal,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                             TextSpan(
//                                 text: ''' PVT LMT''',
//                                 style: TextStyle(
//                                   fontSize: 7,
//                                   // color: PdfColors.indigo,
//                                   fontStyle: FontStyle.normal,
//                                   font: Font.ttf(maintextFont),
//                                 )),
//                           ],
//                           style: const TextStyle(
//                             lineSpacing: 10,
//                             fontSize: 14,
//                           ),
//                         ),
//                         textAlign: TextAlign.center),
//
// //
//                   ),
//                   // RichText(text:const TextSpan(text:'''K A T E International''', ),)
//                 ),
//                 Positioned(
//                   bottom: 60,
//                   child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 70),
//                       height: 90,
//                       width: PdfPageFormat.a4.landscape.width,
//                       // color:  PdfColors.red,
//                       child: Row(
//                         children: [
//                           Container(
//                               width: 150,
//                               child: Column(children: [
//                                 Image(trainer,
//                                     fit: BoxFit.fill, width: 100, height: 40),
//                                 Divider(),
//                                 Text('''HSE Trainer:
// Eng Shahan Bacha ''',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       // color: PdfColors.indigo,
//                                       fontStyle: FontStyle.normal,
//                                       font: Font.ttf(maintextFont),
//                                     )),
//                               ])),
//                           Spacer(),
//                           Container(
//                               width: 150,
//                               child: Column(children: [
//                                 Image(organizer,
//                                     fit: BoxFit.fill, width: 100, height: 40),
//                                 Divider(),
//                                 Text('''Training Organiser:
// Eng Farooq khan''',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       // color: PdfColors.indigo,
//                                       fontStyle: FontStyle.normal,
//                                       font: Font.ttf(maintextFont),
//                                     )),
//                               ])),
//                         ],
//                       )),
//                 ),
//                 Positioned(
//                     bottom: 2,
//                     child: Container(
//                       alignment: Alignment.center,
//                       width: PdfPageFormat.a4.landscape.width,
//                       height: 10,
//                       child: Text(
//                           '''Certification can be validated through the KATE website (kateintl.com) ''',
//                           style: TextStyle(
//                             fontSize: 9,
//                             color: PdfColors.orange,
//                             fontStyle: FontStyle.normal,
//                             font: Font.ttf(maintextFont),
//                           )),
//                     )),
//               ]),
//         ),
//       );
//
//       // print('2');
//     }).then((a) async {
//       // print('3');
//
//       Uint8List pdfInBytes = await pdf.save();
//       // final blob = html.Blob([pdfInBytes], 'application/pdf');
//       // final url = html.Url.createObjectUrlFromBlob(blob);
//       //
//       // anchor = html.document.createElement('a') as html.AnchorElement
//       //   ..href = url
//       //   ..style.display = 'none'
//       //   ..download = '${name}_$registration.pdf';
//       // html.document.body!.children.add(anchor);
//       // // print('4');
//       // val = 4;
//       return pdfInBytes;
//     })
//         // .whenComplete(() => anchor.click())
//         // .whenComplete(() => Connect.appAlert(context,
//         //         content: const app.Text('download will begins shortly'),
//         //         title: 'Downloading...', okPressed: () {
//         //       app.Navigator.pop(context);
//         //     }));
//
//         .then((file) => Connect.appAlert(context,
//                 content: app.Container(
//                     width: _width,
//                     height: _height,
//                     child: SfPdfViewer.memory(file)),
//                 title: 'Downloading...', okPressed: () {
//               app.Navigator.pop(context);
//             }));
//   }
//
//   Future demoPDF(context) async {
//     await rootBundle.load("fonts/DancingScript-Regular.ttf").then((fonts) {
//       pdf.addPage(
//         Page(
//           margin: EdgeInsets.zero,
//           pageFormat: PdfPageFormat.a4.landscape,
//           build: (Context context1) => Stack(alignment: Alignment.center,
//               // overflow: Overflow.clip,
//               children: [
//                 // Watermark(child:Image(watermark, height: 200,width: 110,) ),
//                 // Container(width:PdfPageFormat.a4.landscape.width,height: PdfPageFormat.a4.landscape.height,color: PdfColors.white.shade(20), ),
//
//                 // Image(backgroung, fit: BoxFit.cover),
//                 Text('hello PDF')
//               ]),
//         ),
//       );
//
//       // print('2');
//     }).then((a) async {
//       // print('3');
//
//       Uint8List pdfInBytes = await pdf.save();
//       // final blob = html.Blob([pdfInBytes], 'application/pdf');
//       // final url = html.Url.createObjectUrlFromBlob(blob);
//       //
//       // anchor = html.document.createElement('a') as html.AnchorElement
//       //   ..href = url
//       //   ..style.display = 'none'
//       //   ..download = '${name}_$registration.pdf';
//       // html.document.body!.children.add(anchor);
//       // // print('4');
//       // val = 4;
//       return pdfInBytes;
//     })
//         // .whenComplete(() => anchor.click())
//         // .whenComplete(() => Connect.appAlert(context,
//         //         content: const app.Text('download will begins shortly'),
//         //         title: 'Downloading...', okPressed: () {
//         //       app.Navigator.pop(context);
//         //     }));
//
//         .then((file) => Connect.appAlert(context,
//                 content: app.Container(
//                     width: _width,
//                     height: _height,
//                     child: SfPdfViewer.memory(file)),
//                 title: 'Downloading...', okPressed: () {
//               app.Navigator.pop(context);
//             }));
//   }
// }
