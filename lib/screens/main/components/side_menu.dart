import 'package:admin/models/Panier.dart';
import 'package:admin/models/Reservation.dart';
import 'package:admin/screens/dashboard/components/recent_Categories.dart';
import 'package:admin/screens/dashboard/components/recent_articles.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/loginScreen.dart';
import 'package:admin/screens/Events/events_screen.dart';
import 'package:admin/screens/News/news_screen.dart';
import 'package:admin/screens/livraison/dashboard_livraison.dart';
import 'package:admin/screens/pc/dashboard_Pc.dart';
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
            svgSrc: "assets/icons/menu_profile.svg",
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
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecentCategories()),
              );
            },
          ),
          DrawerListTile(
            title: "Articles",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecentArticles()),
              );
            },
          ),
          DrawerListTile(
  title: "Point Collecte",
  svgSrc: "assets/icons/menu_notification.svg",
  press: (){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> DashboardPC()),
    );
  },
),
          DrawerListTile(
            title: "Livraison",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> DashboardLivraison()),
    );
  },
),
          DrawerListTile(
            title: "Evenements",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventsScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "News",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewsScreen(),
                ),
              );
            },
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
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Log out",
            svgSrc: "images/logout.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
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
