import 'package:flutter/material.dart';

class DeveloperInformation extends StatelessWidget {
  const DeveloperInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Information'),
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
                  child: RichText(
                    text:const TextSpan(
                      children: <TextSpan>[
                       TextSpan(
                              text:
                                  '  RentMaster is developed by [Your Company Name], a dedicated team of software engineers passionate about delivering innovative solutions for property management. ',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                            
                  
                            TextSpan(
                              text:
                                  ' With a strong commitment to excellence and customer satisfaction, we continuously strive to enhance RentMaster functionality and usability\n\n.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                  
                            TextSpan(
                              text:
                                  'For support inquiries or feedback, please contact us at Email hrithunath777@gmail.com',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                            
                  
                      ]
                    ),
                    
                  
                    
                  
                    
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