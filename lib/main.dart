import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/dashboard/components/loginScreen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/constants.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dashboard admin ',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
