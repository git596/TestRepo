import 'package:flutter/material.dart';

class HourlyForcast extends StatelessWidget {   //create HourlyForcast class
  final String time;                           //declares final variables
  final String temperature;
  final IconData icon;
  const HourlyForcast({                   //constructor for HourlyForcast class
    super.key, 
    required this.time,                 //declares required named parameters for the constructor,
    required this.temperature, 
    required this.icon,
    });

  @override
  Widget build(BuildContext context) {
    return Card(                              //hourlyforcast information is displayed as cards
          elevation: 6,
          color: const Color.fromARGB(245, 1, 18, 28),  // Set background color for cards
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(8.0),           //add a padding to all 4 dimensions
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),    //round the borders of containers
            ),
            child: Column(                  // information (time, icon , temp) of a card is displayed as a column
              children: [
                Text(
                        time,
                        style: const  TextStyle(    //styles for time
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,                            
                        ),
                      maxLines: 1 ,                         //take maximum one line to display time
                      overflow: TextOverflow.ellipsis,      //to select the format of the time
                    ),

                const SizedBox(height: 8),

                Icon(
                      icon, 
                      size: 32,                             //styles for icon
                      color: Colors.white,
                    ),

                  const SizedBox(height: 8),

                  Text(
                        '$temperature °C',                //styles for tempurature
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                      ),
                ],
              ),
            ),
          );
        }
      }