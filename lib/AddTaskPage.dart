import 'package:clockify_clone/data/addTask_controller.dart';
import 'package:clockify_clone/model/task.dart';
import 'package:clockify_clone/theme/Theme.dart';
import 'package:clockify_clone/widgets/input_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final AddTaskController _taskController = Get.put(AddTaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectData = DateTime.now();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  List<int> remindList = [
    5,
    10,
    15,
    20,
    25,
    30,
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: headingStyle,
        ),
        backgroundColor: primaryColor,
        toolbarHeight: 100,
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInputField(title: "Title", hint: "Enter your title",controller: _titleController,),
              MyInputField(title: "Note", hint: "Enter your note",controller: _noteController,),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectData),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUSer();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                    title: "Start Date",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )),
                  SizedBox(width: 12),
                  Expanded(
                      child: MyInputField(
                    title: "End Date",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ))
                ],
              ),
              MyInputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList()),
              ),
              MyInputField(
                title: "Remind",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value!,
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList()),
              ),
              SizedBox(height: 12),
              Row(
                children: [_colorPalate()],
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF487da3)),
                  ),
                  onPressed: () {
                    _validateData();
                  },
                  child: const Center(
                    child: Text("Add Task")
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
_validateData(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskTodb();
      Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.grey,
          icon: Icon(
              Icons.warning_amber));
    }
}



  _addTaskTodb() async{
   int value = await _taskController.addTask(
       task:Task(
         note:  _noteController.text,
         title: _titleController.text,
         date: DateFormat.yMd().format(_selectData),
         startTime: _startTime,
         endTime: _endTime,
         remind: _selectedRemind,
         repeat: _selectedRepeat,
         color: _selectedColor,
         isCompleted: 0,
       )
   );
   print("My id is " + "$value");
  }


  _colorPalate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(height: 8.0),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                  radius: 14,
                  backgroundColor: index == 0
                      ? pinkClr
                      : index == 1
                          ? yellowClr
                          : blueClr,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _getDateFromUSer() async {
    DateTime? _pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickDate != null) {
      setState(() {
        _selectData = _pickDate;
      });
    } else {
      print("It is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formedTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}
