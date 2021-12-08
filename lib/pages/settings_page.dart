import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        StackProfile(),
        Positioned(top: 30, bottom: 20, child: CategoryBox()),
        Positioned(bottom: 10, child: SettingsList())
      ],
    );
  }
}

class BottomBody extends StatelessWidget {
  const BottomBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Expanded(child: SafeArea(child: CategoryBox())),
        SettingsList(),
      ],
    );
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(child: SwitchListTile(value: false, onChanged: (value) {}));
  }
}

class CategoryBox extends StatelessWidget {
  const CategoryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Chip(
            label: const Text(
              "GAMING",
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.pink.shade100,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: const Chip(
            label: Text(
              "BOOK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            backgroundColor: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: const Chip(
            label: Text(
              "MUSIC",
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.grey,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: const Chip(
            label: Text(
              "FILM",
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class StackProfile extends StatelessWidget {
  const StackProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc('iZN81Glj4JIaCXi2Wm2s')
            .collection('user')
            .get(),
        builder: (_, snapshot) {
          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              const HalfCircle(),
              const Positioned(
                  top: 80, left: 30, right: 30, child: BannerProfile()),
              Positioned(
                top: 40,
                left: 32,
                child: SafeArea(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () {
                        print(snapshot.data!.docs.first.get('name'));
                      },
                      child: Image.network(
                        snapshot.data!.docs.first.get('imagelinks'),
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

class BannerProfile extends StatelessWidget {
  const BannerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.8,
        color: Colors.grey,
      ),
    );
  }
}

class HalfCircle extends StatelessWidget {
  const HalfCircle({Key? key}) : super(key: key);
  final double diameter = 390;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomPaint(
        painter: HalfCirclePainter(),
        size: Size(diameter, diameter),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, 0),
            width: size.width,
            height: size.height),
        math.pi,
        -math.pi,
        false,
        Paint()..color = Colors.pink.shade50);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
