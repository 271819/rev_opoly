// class Bot{
//   String score,money;
  
//   Bot.fromJson(Map json)
//     : score = json['score'],
//       money = json['money'];
      
//   Map toJson(){
//     return{'score':score, 'money':money};
//   } 
// }


import 'dart:convert';

List<Bot>botFromJson(String str)=>List<Bot>.from(json.decode(str).map((x)=> Bot.fromJson(x)));

String botToJson(List<Bot>data)=>json.encode(List<dynamic>.from(data.map((x)=>x.toJson())));

class Bot {
  String score,money;

  Bot(
    {
      this.score,
      this.money,
    }
  );

  factory Bot.fromJson(Map<String, dynamic> json)=>Bot(
    score:json['score'],
    money:json['money'],
  );

  Map<String, dynamic> toJson() =>{
    "score":score,
    "money":money,
  };
}