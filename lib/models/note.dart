class Note{
  int id;
  String name;
  String date;
  String notes;
  String position;

  Note({this.name, this.date, this.position, this.notes});

  Note.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    date = json['date'];
    notes = json['notes'];
    position = json['position'];
  }

  Map<String, dynamic> toMJson(){
    return{
      'id': id,
      'name': name,
      'date': date,
      'notes': notes,
      'position': position,
    };
  }
}