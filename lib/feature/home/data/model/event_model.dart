import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  late  String? id;
  final String title;
  final String des;
  final String image;
  final String date;
  final String time;
  final String categoryId;
  List<String>?users;
   bool fav ;

  EventModel({
     this.id,
    this.fav=false,
    this.users,
    required this.title,
    required this.des,
    required this.image,
    required this.date,
    required this.time,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    var data = {
      "title": title,
      "id": id,
      "des": des,
      "image": image,
      "date": date,
      "time": time,
      "categoryId": categoryId,
      "fav":fav,
      "users":users,
    };
    return data;
  }


  factory EventModel.fromJson(Map<String, dynamic> json) {
     List<String> usersFav=(json["users"]as List? ??[]).map((e) {
       return e.toString();
     },).toList();
     bool isFound=usersFav.contains(FirebaseAuth.instance.currentUser?.uid);
    return EventModel(
      id: json["id"],
      title: json["title"],
      des: json["des"],
      image: json["image"],
      date: json["date"],
      time: json["time"],
      fav: isFound,
      categoryId: json["categoryId"],
      users: usersFav
    );
  }
}
