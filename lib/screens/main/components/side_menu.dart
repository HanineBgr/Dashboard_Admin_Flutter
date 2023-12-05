import 'package:admin/models/Panier.dart';
import 'package:admin/models/Reservation.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("images/logo.png"),
          ),
          DrawerListTile(
            title: "Overview",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {},
          ),
         DrawerListTile(
  title: "Utilisateurs",
  svgSrc: "assets/icons/menu_tran.svg",
  press: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecentFiles()),
    );
  },
),
          DrawerListTile(
            title: "Catégories",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Articles",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Evenements",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Livraison",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Réservation",
            svgSrc: "assets/icons/menu_notification.svg",
           press:  () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservationPage()),
    ); },
          ),
          DrawerListTile(
            title: "Panier",
            svgSrc: "assets/icons/menu_notification.svg",
            press:  () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PanierPage()),
    );
  },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
