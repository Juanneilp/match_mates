import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const routeNamed = "/about_page";
  AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Center(
                    child: Image.asset(
                  'assets/app_icon.png',
                  width: 50,
                  height: 50,
                )),
                SizedBox(
                  height: 20,
                ),
                Text('''
          \t Terima kasih telah memaki aplikasi Match mates, match mates merupakan aplikasi yang digunnakan untuk membantu orang yang malu dan orang yang sendiri, dijauhi teman, dan berbagai halangan lainnya, diharapkan dengan adanya pengguna bisa mendapat rasa percaya dan melangkah menuju hidup lebih baik. 
          '''
                    .trimRight()),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text("matchmates2021@gmail.com"),
                )
              ],
            )),
      ),
    );
  }
}
