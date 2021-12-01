//just for testing it will be deleted when the rea data is ready
class TextChat {
  bool user;
  String chatString;
  TextChat({required this.chatString, required this.user});
}

var chatlist = [
  TextChat(chatString: "halo kmu siapa", user: false),
  TextChat(chatString: "ini dengan siapa ya", user: true),
  TextChat(chatString: "ooga booga", user: false),
  TextChat(chatString: "OOGA BOOGA", user: true),
];
