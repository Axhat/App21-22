import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/sponsor_list.dart';

class Sponsors extends StatelessWidget {
  Sponsors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Our Sponsors',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 30,
                color: white,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SponsorsWidget(),
          ],
        ),
      )),
    );
  }
}
