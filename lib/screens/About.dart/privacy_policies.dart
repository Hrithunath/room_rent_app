import 'package:flutter/material.dart';

class Privacy  extends StatelessWidget {
  const Privacy ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Policies'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: RichText(text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Thank you for choosing our Offline Task Manager App (Manage You), This Privacy Policy is intended to inform you about the types of information we collect and how we use and protect that information,Your privacy is important to us, and we are committed to ensuring the confidentiality and security of any personal information you provide',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        ),
                            TextSpan(
                              text: '\n\nData Collection:\n\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              TextSpan(
                        text: 'The Company may collect personal information from you when you use the App. This may include but is not limited to, your name, email address, contact information, and usage data.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        ),
                        TextSpan(
                              text: '\n\nUse of Information::\n\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          TextSpan(
                        text: 'The Company may use the information collected to provide and improve the App, to communicate with you, to personalize your experience, and for other legitimate business purposes.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        ),
                         TextSpan(
                              text: '\n\nData Sharing:\n\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                         TextSpan(
                        text: 'The Company may share your personal information with third-party service providers that assist in providing the App or as required by law. Your information may also be disclosed in connection with a business transaction.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        ),
                       TextSpan(
                              text: '\n\nData Security:\n\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            TextSpan(
                        text: 'The Company takes reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        ),  
                       TextSpan(
                              text: '\n\nChildrens Privacy:\n\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                                 TextSpan(
                        text: 'Our services are not intended for individuals under the age of 18. We do not knowingly collect personal information from children under 18. If you believe that we have collected personal information from a child under 18, please contact us immediately.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        ),   
                       TextSpan(
                              text: '\n\nUpdates to This Privacy Policy:\n\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        TextSpan(
                              text: 'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                                 TextSpan(
                        text: '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        ),    
                       TextSpan(
                              text: '\n\nContact Us: \n\n',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             TextSpan(
                              text: 'If you have any questions or concerns about our Privacy Policy, please contact us at [hrithunath777@gmail.com].',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                                                  
                    ]
                  )
                  ),
                ),
              )
            ]
          )
        )
      )
    );
  }
}