import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techapp/screens/auth/firebase_services.dart';
import 'package:techapp/screens/auth/google_login.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      elevation: 1,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: DrawerHeader(
              child: Column(
                children: [
                  FirebaseAuth.instance.currentUser != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL!),
                          radius: 40,
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/altius.png',
                          ),
                          radius: 40,
                        ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "${FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.displayName : "Dummy Name"}",
                    style: h4s,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  AutoSizeText(
                    "${FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email : "Dummy Email"}",
                    style: h4s,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text(
              'Home',
              style: h4s,
            ),
            leading: Icon(
              Icons.home,
              color: glowColor,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/navigation', ModalRoute.withName('/navigation'));
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: glowColor.withOpacity(0.5),
          ),
          DrawerItem(
              title: "My Events",
              route: '/my_events',
              icon: Icons.calendar_today_rounded),
          DrawerItem(
              title: "Team Altius", route: '/team_altius', icon: Icons.group),
          DrawerItem(
              title: "Developers ",
              route: '/developers',
              icon: Icons.developer_mode),
          ListTile(
            title: Text('Your Profile', style: h4s),
            leading: Icon(
              Icons.person,
              color: glowColor,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: glowColor.withOpacity(0.5),
          ),
          ListTile(
            title: Text('Website', style: h4s),
            leading: FaIcon(
              FontAwesomeIcons.desktop,
              size: 25,
              color: glowColor,
            ),
            onTap: () async {
              if (!await launch(
                  'https://website-frontend20-2mkfatxre.vercel.app/')) {
                print('invalid link');
              }
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: glowColor.withOpacity(0.5),
          ),
          ListTile(
            title: Text('Logout', style: h4s),
            leading: Icon(
              Icons.logout_outlined,
              color: glowColor,
            ),
            onTap: () async {
              await FirebaseServices().googleSignOut();
              Navigator.popUntil(context, (route) => false);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GoogleLoginScreen()));
            },
          ),
          Divider(height: 1, thickness: 1, color: glowColor.withOpacity(0.5)),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            child: AutoSizeText(
              'Made with 🤍 by Technobyte',
              textAlign: TextAlign.center,
              style: TextStyle(color: glowColor, fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;

  DrawerItem({
    Key? key,
    required this.title,
    required this.route,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: h4s),
          leading: Icon(
            icon,
            color: glowColor,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          },
        ),
        Divider(height: 1, thickness: 1, color: glowColor.withOpacity(0.5)),
      ],
    );
  }
}
