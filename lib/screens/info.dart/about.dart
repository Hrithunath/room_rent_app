import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Rent App',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '1.0.0',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'About this app\n\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Rent App',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '  is a comprehensive application designed to simplify the management of apartment for owners.\nWith ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: 'Rent App',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ',  the owner can effortlessly oversee  keeping track of available rooms, rent payments, and revenue generation. ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: 'Rent App',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' will Replace all the paper works that the Appartment owner normally doing in his Appartment and easy to understand.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '\n\nDeveloper Information\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) =>
                          //             const DeveloperInformation(),
                          //       ),
                          //     );
                          //   },
                        ),
                        TextSpan(
                          text: '\nPrivacy Policy\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => const PrivacyPolicy(),
                          //       ),
                          //     );
                          //   },
                        ),
                        TextSpan(
                          text: '\nTerms & Conditions\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) =>
                          //             const TermsAndConditions(),
                          //       ),
                          //     );
                          //   },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
