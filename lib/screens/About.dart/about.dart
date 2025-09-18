import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:room_rent_app/screens/About.dart/developer_information.dart';
import 'package:room_rent_app/screens/About.dart/privacy_policies.dart';
import 'package:room_rent_app/screens/About.dart/terms_conditions.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'StayIn',
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
                    text:  TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'About this app\n\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: 'StayIn',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              '  is a comprehensive application tailored for single-owner users to streamline the management of rental properties with efficiency and ease.\n Developed ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ',  with the latest technology, StayIn simplifies the complexities of property management,  ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                    
                        const TextSpan(
                          text:
                              ' enabling landlords to focus on maximizing their rental income while providing excellent service to tenants.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        const TextSpan(
                          text: '\n\nKey Features\n\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                         const TextSpan(
                          text: 'Intuitive Room Management:',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const TextSpan(
                          text:
                              ' Easily add, edit, and organize rooms within your apartment property. With RentMaster intuitive interface, managing your property layout has never been easier.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        
                        const TextSpan(
                          text: '\n\nSeamless Occupancy Tracking:',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const TextSpan(
                          text:
                              ' Keep track of room occupancy status effortlessly, from vacant to occupied, allowing you to monitor the availability of rooms in real-time.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                         const TextSpan(
                          text: '\n\nComprehensive Tenant Profiles:',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const TextSpan(
                          text:
                              ' Maintain detailed records of tenants, including contact information, lease agreements, and rental history. RentMaster comprehensive tenant profiles help you stay organized and informed.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        const TextSpan(
                          text: '\n\nEfficient Payment Tracking:',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                    const    TextSpan(
                          text:
                              ' Monitor rent payments and track financial transactions with precision. StayIn built-in payment tracking feature provides clarity on outstanding payments and ensures timely revenue collection.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                    const    TextSpan(
                          text: '\n\nFeedback Notes and Communication::',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                    const    TextSpan(
                          text:
                              ' Capture tenant feedback and communicate effectively with built-in notes and messaging features. Addressing tenant concerns promptly enhances tenant satisfaction and fosters positive relationships.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                    const    TextSpan(
                          text: '\n\nSecure Document Management:',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      const  TextSpan(
                          text:
                              ' Safely store and manage important documents such as lease agreements, rental applications, and maintenance records. RentMaster document management system keeps your paperwork organized and easily accessible.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                       const TextSpan(
                          text: '\n\nInsightful Revenue Reporting:',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const TextSpan(
                          text:
                              ' Gain valuable insights into your property financial performance with detailed revenue reports. Analyze rental income, expenses, and occupancy rates to make informed decisions and optimize profitability.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '\n\nDeveloper Information\n',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DeveloperInformation(),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '\nPrivacy Policy\n',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Privacy(),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '\nTerms & Conditions\n',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditions(),
                                ),
                              );
                            },
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
