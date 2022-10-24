import 'dart:ffi';
import 'dart:math';

import 'package:dual_screen/app_page.dart';
import 'package:dual_screen/constants.dart';
import 'package:dual_screen/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences? prefs;
  String? password;
  String currentText = '';

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      prefs = sp;
      password = sp.getString('password');
      // will be null if never previously saved
      if (password == null) {
        password = '';
        savePassword(''); // set an initial value
      }
      setState(() {});
    });
  }

  void savePassword(String value) {
    setState(() {
      password = value;
    });
    prefs?.setString('password', value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController tController = new TextEditingController();

    return Scaffold(
      backgroundColor: Constants().blackMenuColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(
              size: 50,
              Icons.lock_open,
              color: Colors.white,
            ),
            Text(
              password != '' ? 'Type a password' : 'Pick a password',
              style: Constants().boldWhiteText,
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Form(
                    child: PinCodeTextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      pinTheme: PinTheme(
                          selectedColor: Colors.black,
                          inactiveColor: Colors.black),
                      length: 4,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      controller: tController,
                      onChanged: (value) {
                        currentText = value;
                      },
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Constants().buttonColor),
              height: 56,
              width: MediaQuery.of(context).size.width - 112,
              child: TextButton(
                  onPressed: (() {
                    if (password != '') {
                      if (password == currentText) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AppPage()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialogBox(
                                title: 'Incorrect',
                                descriptions: 'Please type correct password'));
                        print('Incorrect');
                      }
                      ;
                    } else if (currentText.length < 4) {
                      print('More characters');
                      print(currentText.length);
                      print(currentText);
                      tController.clear();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialogBox(
                              title: 'Too short',
                              descriptions:
                                  'Password must have at least 4 characters'));
                    } else {
                      savePassword(currentText);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginPage()));
                    }
                  }),
                  child: Text(
                    password != '' ? 'Enter' : 'Set Password',
                    style: Constants().boldBlackTextTwentySix,
                  )),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
