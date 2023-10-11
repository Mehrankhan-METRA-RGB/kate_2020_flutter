import 'package:flutter/material.dart';

class CourseDetails extends StatefulWidget {
  final String? courseHeading;
  final List<ExpansionModel>? expansionList;
  final List? sideTileList;
  CourseDetails({this.courseHeading,this.expansionList,this.sideTileList});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  var _width, _height;
List<ExpansionModel> data=[
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
];
List list=['NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course',
  'NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course','NEBOSH IGC is a SCQF level 6 course',];
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    print(_width);
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return ListView(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                width: _width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.red,
                      ],
                    )),
                child: Center(
                  child: ListTile(
                    title: Text(
                      widget.courseHeading!,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: constraint.maxWidth > 700 ? 38 : 20),
                    ),
                  ),
                ),
              ),
              constraint.maxWidth>804? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailExpansionTile(widget.expansionList!,_width*0.67),
                  // Spacer(),
                  sideTile(widget.sideTileList!,_width*0.3),
                ],):Container(height: ((widget.expansionList!.length*90)+(widget.sideTileList!.length*55+90))*3,

                child: Column(children: [
                  detailExpansionTile(widget.expansionList!,_width),
                  // Spacer(),
                  sideTile(widget.sideTileList!,_width),
                ],),
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],



        );
      }),
    );
  }

 Widget detailExpansionTile(List<ExpansionModel> list,_width){

    return  Container(
      width: _width,
      child: Column(children: [
for (ExpansionModel element in list)
        ExpandableWidget(
          heading: element.heading,
          expandedData: '''${element.text}''',headingSize: _width>604?25:16,textSize: _width>604?16:13 ,),




      ],),
    );


  }
 Widget sideTile(List list,_width){

    return  Container(
        margin:EdgeInsets.symmetric(horizontal: 10,vertical: 5),color: Color(0x5EB3BCD2),
        width: _width,
        child: Column(children: [
          for (var element in list)
          ListTile(
            leading: Icon(Icons.check_circle_outline_rounded,color: Colors.deepOrange,),
            title: Text(element,style: TextStyle(fontSize: _width>604?18:14),),
          ),



        ],));


  }


}
class ExpansionModel{
 final  String? heading;
  final String? text;
    ExpansionModel({this.heading, this.text});
}
class ExpandableWidget extends StatelessWidget {
  final String? heading;
  final String? subHeading;
  final String? expandedData;
  final double? headingSize;
  final double? textSize;
  final Color? textColor;
  final Color? headingColor;
  ExpandableWidget(
      {this.heading,
      this.textSize = 14,
      this.expandedData,
      this.textColor=Colors.black87,
      this.headingColor=Colors.white70,
      this.headingSize = 25,
      this.subHeading});

  var _width, _height;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 20,left: 5,right: 5),
       color:Colors.orange ,
      child: ExpansionTile(
        textColor: Colors.black87,
        collapsedTextColor: Colors.black87,

        backgroundColor: Colors.orange,
        title: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              Colors.orange,
              Colors.red,
            ],
          )),
          child: ListTile(
            title: Text(
              heading!,
              style: TextStyle(
                fontSize: headingSize!,
                color: headingColor!,
              ),
            ),
            subtitle: subHeading != null
                ? Text(
                    subHeading!,
                    style: TextStyle(
                      fontSize: _width > 598.0 ? 16 : 11,
                    ),
                  )
                : null,
          ),
        ),
        childrenPadding: EdgeInsets.all(25),
        children:  [
          SelectableText.rich(TextSpan(text: expandedData!,style: TextStyle(fontSize: textSize!,color: textColor))),
        ],
      ),
    );
  }
}
