// import 'dart:convert';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/authentications/blog/news_blog.dart';
import 'package:kate/authentications/course_registeration.dart';
import 'package:kate/authentications/jobs/jobs_view.dart';
import 'package:kate/authentications/testimonials/testimonial_view.dart';
import 'package:kate/authentications/verification.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/data.dart';
import 'package:kate/constants/urls.dart';
import 'pdf_certificate.dart';
import 'package:kate/widgets/training_calender.dart';

class Students extends StatefulWidget {
  final uploader;
  final course;
  Students({this.uploader = 'No Admin', this.course = 'IOSH'});
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  var _height, _width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: Data.courses.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            indicator:const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: AppColors.primary,
            ),
            tabs: [
              for(var course in Data.courses)
              Tab(height: 30, icon: Text(course)),

            ],
          ),
          toolbarHeight: 50,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            for(var course in Data.courses)
            Certificate(course),

          ],
        ),
      ),
    );
  }
}
