class MessageModel{

    String? message;
    String? image;
    String? senderId;
    String? receiverId;
    String? dateTime;

  MessageModel({
    this.message,
    this.receiverId,
    this.senderId,
    this.dateTime,
    this.image
  });

   MessageModel.fromJson( Map<String,dynamic>jsonData){
      message= jsonData['message'];
      image= jsonData['image'];
        receiverId=jsonData['receiverId'];
        senderId=jsonData['senderId'];
      dateTime=jsonData['dateTime'];
  }

  Map<String,dynamic> toMap(){
     return{
       'message':message,
       'receiverId':receiverId,
       'senderId':senderId,
       'dateTime':dateTime,
       "image":image
     };
  }
}