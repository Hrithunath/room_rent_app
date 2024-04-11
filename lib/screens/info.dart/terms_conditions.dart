import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
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
                      text: '\nAcceptance of Terms:\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                       fontWeight: FontWeight.bold, 
                      )
                    ),
                    TextSpan(
                      text: 'By using our application, you agree to be bound by these Terms and Conditions. If you do not agree to these Terms and Conditions, you may not use our application.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                      TextSpan(
                      text: '\n\nUse of the Application: \n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                      TextSpan(
                      text: 'You may use our application for lawful purposes only. You agree not to use our application for any illegal or unauthorized purpose.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                      TextSpan(
                      text: '\n\nUser Accounts:\n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                      TextSpan(
                      text: 'You may be required to create a user account to access certain features of our application. You are responsible for maintaining the confidentiality of your account credentials and for any activities that occur under your account.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                      TextSpan(
                      text: '\n\nIntellectual Property:\n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                      TextSpan(
                      text: 'Our application and its content, including but not limited to text, graphics, logos, and images, are the property of [Your Company Name] and are protected by copyright and other intellectual property laws.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                      TextSpan(
                      text: '\n\nLimitation of Liability: \n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                      TextSpan(
                      text: 'We are not liable for any damages, including but not limited to direct, indirect, incidental, consequential, or punitive damages, arising out of or in connection with your use of our application.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                       TextSpan(
                      text: '\n\nIndemnification: \n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                     TextSpan(
                      text: 'You agree to indemnify and hold harmless [Your Company Name] and its affiliates, officers, directors, employees, and agents from any claims, liabilities, damages, losses, or expenses arising out of or in connection with your use of our application.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                     TextSpan(
                      text: '\n\nGoverning Law: \n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                     TextSpan(
                      text: 'These Terms and Conditions shall be governed by and construed in accordance with the laws of India.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                     TextSpan(
                      text: '\n\nChanges to These Terms and Conditions:\n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                     TextSpan(
                      text: 'We reserve the right to update or modify these Terms and Conditions at any time without prior notice. Your continued use of our application after any such changes constitutes your acceptance of the new Terms and Conditions.\n\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                      
                      TextSpan(
                      text: 'If you have any questions or concerns about these Terms and Conditions, please contact us at hrithunath777@gmail.com',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.5,
                      )
                    ),
                  ]
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}