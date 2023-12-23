import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/dashboard_Pc.dart';
import 'package:admin/screens/dashboard/dashboard_livraison.dart';
import 'package:admin/screens/dashboard/mapp.dart';
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
  title: "Livraison",
  svgSrc: "",
  press: (){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> DashboardLivraison()),
    );
  },
),
DrawerListTile(
  title: "Point Collecte",
  svgSrc: "",
  press: (){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> DashboardPC()),
    );
  },
),
DrawerListTile(
  title: "Map",
  svgSrc: "",
  press: (){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> LocalMap()),
    );
  },
),
        /* DrawerListTile(
  title: "Livraison",
  svgSrc: "assets/icons/menu_tran.svg",
  press: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StorageDetails()),
    );
  },
),*/
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
          /* DrawerListTile(
            title: "Point de Collecte",
            svgSrc: "assets/icons/menu_",
            press: () {},
          ),*/
          DrawerListTile(
            title: "Réservation",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Panier",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
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
