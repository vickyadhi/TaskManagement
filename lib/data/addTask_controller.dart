import 'package:clockify_clone/data/db/db_helper.dart';
import 'package:clockify_clone/model/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }
  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }

  void getTask()async{
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }


}