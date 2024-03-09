import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {    //create AdditionalInfo class
  final IconData icon;      //declares final variables
  final String label;
  final String value;
  const AdditionalInfo({    //constructor for additionalInfo class
    super.key,
    required this.icon,     //declares required named parameters for the constructor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(          //icon , label and value is displayed as a column
      children: [
        Icon(
          icon,             //styles for icon
          size: 32,
          color: const Color.fromARGB(255, 194, 184, 184),
        ),

        const SizedBox(height: 8), //put a space between icon and labeltext

        Text(
          label,
          style: const TextStyle(
                                      //styeles for label
            color: Color.fromARGB(255, 194, 184, 184),
          ),
        ),

          const SizedBox(height: 8),   //put a space between label and value
        Text(
              value,
              style: const TextStyle(       //styles for value
                fontSize: 16,
                color: Color.fromARGB(255, 194, 184, 184),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }
    }
