import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(),
            const Spacer(),
            Text(
              "Luxury Palace",
              style: GoogleFonts.yellowtail(
                fontSize: 55,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const SizedBox(width: 35),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      FirebaseController().to.signIn();
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    color: Colors.white,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.g_mobiledata,
                          color: Colors.black,
                          size: 35,
                        ),
                        Text(
                          "Sign in with Google",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 35),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Privacy Policy",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.white,
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Terms and Conditions",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
