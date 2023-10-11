import 'package:flutter/material.dart';
import 'package:kate/authentications/blog/news_blog.dart';
import 'package:kate/authentications/course_registeration.dart';
import 'package:kate/authentications/jobs/jobs_view.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/courses/contacts.dart';
import 'package:kate/courses/course_details.dart';
import 'package:kate/courses/gallery.dart';

class MainTabBar extends StatelessWidget {
  var _width;
  @override
  Widget build(BuildContext context) {
    _width=MediaQuery.of(context).size.width;
    return  Container(

      width: _width-150,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            MaterialButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>CourseDetails(
                      sideTileList:const ['NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course',
                        'NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course',],
                      expansionList: [
                        ExpansionModel(heading: 'What is NEBOSH IGC?',text: '''The NEBOSH IGC Training Course also known as NEBOSH International General Certificate is a qualification that covers a wide-range of health and safety topics, from helping employers understand their legal and moral responsibilities, to even more superior subject-matter such as conducting risk assessments by employees. compare NEBOSH online training

The National Examination Board in Occupational Safety and Health (NEBOSH) is a UK-based independent examination board delivering vocational qualifications in health, safety and environment practice and management

The NEBOSH IGC, Oil & Gas, Construction safeties are safety level 6 and a perfect step towards the NEBOSH Diploma – which is equivalent to a Bachelor’s degree.'''),
                        ExpansionModel(heading: 'What is NEBOSH IGC?',text: '''The NEBOSH IGC Training Course also known as NEBOSH International General Certificate is a qualification that covers a wide-range of health and safety topics, from helping employers understand their legal and moral responsibilities, to even more superior subject-matter such as conducting risk assessments by employees. compare NEBOSH online training

The National Examination Board in Occupational Safety and Health (NEBOSH) is a UK-based independent examination board delivering vocational qualifications in health, safety and environment practice and management

The NEBOSH IGC, Oil & Gas, Construction safeties are safety level 6 and a perfect step towards the NEBOSH Diploma – which is equivalent to a Bachelor’s degree.'''),
                        ExpansionModel(heading: 'Is NEBH IGC suitable for me?',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                        ExpansionModel(heading: 'Is  C suitable for me?',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                        ExpansionModel(heading: 'Is NEBOSH GC sule for me?',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                        ExpansionModel(heading: 'Is NEBOSHor me?',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                        ExpansionModel(heading: 'Is NEBOSH ',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                        ExpansionModel(heading: ' for me?',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                        ExpansionModel(heading: 'IGC suitable for me?',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                        ExpansionModel(heading: 'Is for me?',text: '''The NEBOSH International General Certificate is ideal for everyone seeking to build a career in health and safety management ranging from the intending to existing professionals, oil & gas workers, consultants, top executives, internal & lead auditors, project managers, supervisors.

Prospective learners do not need previous experience to enroll, training or write the international examination.'''),
                      ],
                      courseHeading:'HEAD OF COURSE',

                    ),
                  ),
                );
              },
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('HOME',style: TextStyle(color: AppColors.textBlack),),
              ),),

            MaterialButton(onPressed: (){  Navigator.pop(context);},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: PopupMenuButton(offset:const Offset(0,50),
                itemBuilder: (BuildContext context) {
                  return  [
                    PopupMenuItem(
                      onTap: (){  Navigator.pop(context);},
                      value: 1,
                      child: Text('ISO 45001:2018 Lead Auditor Course|CQI/IRCA certified'),
                    ),
                    PopupMenuItem(
                      onTap: (){  Navigator.pop(context);},
                      value:2,
                      child: Text('ISO 9001:2015 Lead Auditor Course|CQI/IRCA certified'),
                    ),

                  ];
                },
                initialValue: 1,
                elevation: 0,
                child: Center(child: Row(
                  children:const [
                    Text('IRCA ISO COURSE',style: TextStyle(color: AppColors.textBlack),),
                    SizedBox(width: 3,),
                    Icon(Icons.keyboard_arrow_down,color: AppColors.textBlack,)
                  ],
                )),
              ),
            ),

            MaterialButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCourse(),
                  ));},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('UK HSE COURSE',style: TextStyle(color: AppColors.textBlack),),
              ),),
            MaterialButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCourse(),
                  ));},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('BPMA COURSE',style: TextStyle(color: AppColors.textBlack),),
              ),),
            MaterialButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCourse(),
                  ));},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('CONSULTANCY',style: TextStyle(color: AppColors.textBlack),),
              ),),
            MaterialButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogsView(),
                  ));},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('BLOGS',style: TextStyle(color: AppColors.textBlack),),
              ),),
            MaterialButton(
              onPressed: (){  Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobsView(width: _width*0.8,),
                  ));},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('JOBS',style: TextStyle(color: AppColors.textBlack),),
              ),),
            MaterialButton(
              onPressed: (){  Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Gallery(),
                  ));},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('GALLERY',style: TextStyle(color: AppColors.textBlack),),
              ),),
            MaterialButton(
              onPressed: (){   Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Contacts(),
                  ));},
              hoverColor: AppColors.google[3].withOpacity(0.9),
              child: const Center(child:  Text('CONTACT',style: TextStyle(color: AppColors.textBlack),),
              ),),
          ],),

    );
  }
}
