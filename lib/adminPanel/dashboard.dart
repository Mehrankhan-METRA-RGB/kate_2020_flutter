import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/adminPanel/student_tabs.dart';
import 'package:kate/authentications/blog/news_blog.dart';
import 'package:kate/authentications/course_registeration.dart';
import 'package:kate/authentications/jobs/jobs_view.dart';
import 'package:kate/authentications/library/library_view.dart';
import 'package:kate/authentications/requests/students_request.dart';
import 'package:kate/authentications/testimonials/testimonial_view.dart';
import 'package:kate/authentications/verification.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'pdf_certificate.dart';
import 'package:kate/widgets/training_calender.dart';
class Dashboard extends StatefulWidget {
  final uploader;
  Dashboard({this.uploader='No Admin'});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _height,_width,requestLength=0;
  Future<List<StdModel>> requests() async {
    var dio = Dio();
    var response = await dio.get('${AppUrl.temp}fetch/request',);
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    List<StdModel> list = decode.map((user) => StdModel.fromJson(user)).toList();
    setState(() {requestLength= list.length;});
    return list;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     requests();
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return   DefaultTabController(

      length:7,
      child: Scaffold(
        appBar:AppBar(title:
        TabBar(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          isScrollable: true,
          indicatorColor: AppColors.primary,
          indicator:const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: AppColors.primary,),
          tabs:  [
            Tab(height:30,icon: Row(
              children: [
                const Text('Requests'),SizedBox(width:5),
                requestLength>0? Container(height: _width>500?15:12 ,child: CircleAvatar(backgroundColor: Colors.red,child:Text(requestLength.toString(),style: TextStyle(fontSize:_width>500?7:6 ),) ,),):Container(),

              ],
            )),
            Tab(height:30,icon: Text('Students')),
            Tab(height:30, icon: Text('Blog News')),
            Tab(height:30,icon: Text('Jobs')),
            Tab(height:30,icon: Text('Testimonials')),
            Tab(height:30,icon: Text('Calender')),
            Tab(height:30,icon: Text('Library')),


          ],
        ),
          toolbarHeight: 50,elevation: 0,actions: [  Center(child: Text(widget.uploader)),const SizedBox(width: 10,),],),


        body:  TabBarView(
          children: [
            StudentsRequests(),
            Students(),
            BlogsView(isAdmin: true,isSeparate: true,uploader:widget.uploader,width: _width > 800 ? 800 : _width ,),
            JobsView( width: _width > 800 ? 800 : _width,isAdmin: true,isSeparate: true,uploader: widget.uploader,),
            TestimonialsView(width: _width > 800 ? 800 : _width, height: _height,isAdmin: true,isSeparate:true,),
            TrainingCalender(isSeparate:true,isAdmin:true),
            LibraryView(isSeparate:true,isAdmin:true,uploader: widget.uploader,type: null,),


          ],),),
    );
  }
}
