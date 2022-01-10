import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeveloperCard extends StatelessWidget {
  final String imageSrc;
  final String name;
  final String year;
  final String github;
  final String linkedin;
  final String insta;

  const DeveloperCard({
    Key? key,
    required this.imageSrc,
    required this.name,
    required this.year,
    required this.github,
    required this.linkedin,
    required this.insta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white30,
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.5),
              blurRadius: 30,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                imageSrc,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 150,
              ),
            ),
            AutoSizeText(
              name,
              style: h4s,
              maxLines: 1,
            ),
            AutoSizeText(
              year + ' Year',
              style: h5.copyWith(
                color: white.withOpacity(0.8),
              ),
              maxLines: 1,
            ),
            Divider(
              thickness: 2,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      color: white,
                    ),
                    onPressed: () async {
                      if (!await launch(linkedin)) {
                        // show snackbar cannot show link
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar(
                                text: "couldnot process request",
                                context: context));
                      }
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: white,
                    ),
                    onPressed: () async {
                      if (!await launch(linkedin)) {
                        // show snackbar cannot show link
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar(
                                text: "couldnot process request",
                                context: context));
                      }
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: white,
                    ),
                    onPressed: () async {
                      if (!await launch(insta)) {
                        // show snackbar cannot show link
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar(
                                text: "couldnot process request",
                                context: context));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
SnackBar CustomSnackbar({required String text, required BuildContext context}) {
  return SnackBar(
    content: Text(text, textAlign: TextAlign.center),
    backgroundColor: Colors.yellow,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
  );
}
