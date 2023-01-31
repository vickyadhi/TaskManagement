import 'package:clockify_clone/AddTaskPage.dart';
import 'package:clockify_clone/data/addTask_controller.dart';
import 'package:clockify_clone/google_login/AuthService.dart';
import 'package:clockify_clone/service/notification_service.dart';
import 'package:clockify_clone/theme/Theme.dart';
import 'package:clockify_clone/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _selectedDate = DateTime.now();
  final _taskController = Get.put(AddTaskController());
  DateTime _selectDate = DateTime.now();
  var notifyHelper;

  @override
  void initState(){
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIosPermission();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(
       backgroundColor: primaryColor,
       toolbarHeight: 100,
       actions: [

       ],
     ),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTasks(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute( builder: (context) => AddTaskPage()));
         _taskController.getTask();
        },
        backgroundColor: Color(0xFF487da3),
      ),
    );
  }


  _showTasks(){
return Expanded(
    child:Obx((){
  return ListView.builder(
    itemCount: _taskController.taskList.length,
      itemBuilder:(_, context) {
        return Container(
          width: 100,
          height: 50,
          color: Colors.blueAccent,
          margin: EdgeInsets.only(bottom: 10),
        );
      });
}) );
  }


  _addDateBar(){
    return Container(
      margin: EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        onDateChange: (date){
          _selectDate=date;
        },
      ),
    );
  }

  _addTaskBar(){
return  Container(
  margin: EdgeInsets.only(left: 20,right: 20,top: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat.yMMMMd().format(DateTime.now()),
              style: headingStyle,
            ),
            Text("Today",style: headingStyle,)
          ],
        ),
      ),

    ],
  ),

);

  }

  Future openDialogueBox(BuildContext context) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(" Are you sure want you to logout?"),
        actions: [
          ElevatedButton(onPressed: () => {
            AuthService().signOut(),
            Navigator.of(context).pop(true)

          }, child: Text("Yes")),
          ElevatedButton(onPressed: (){}, child: Text("No"))
        ],
      );
    });
  }

}
