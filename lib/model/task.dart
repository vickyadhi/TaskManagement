class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  String? repeat;
  int? remind;
  int? color;

  Task({
this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,this.startTime,this.endTime,this.remind,this.repeat,this.color,

});

  Task.fromJson(Map<String, dynamic>json){
    id = json['id'];
    title = json['title'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
    color = json['color'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic>data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    data['color'] = this.color;
    return data;
  }

}