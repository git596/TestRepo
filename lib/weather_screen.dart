import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/additional_info.dart';
import 'package:weatherapp/hourly_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

final TextEditingController _cityController = TextEditingController();  //new

class _WeatherScreenState extends State<WeatherScreen> {
    

  Future <Map<String, dynamic>> getCurrentWeather(String cityName) async {              //last {
    try{
      //String cityName = 'Colombo';
      final res = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey&units=metric',   //link of Uri
        ),       //uri-uniform resource identifier
      );

      final data = jsonDecode(res.body);

      if(data['cod']!='200'){
        throw 'An Unexpected error occured';    //or use "data['message'];"         //if 
      }

      return data ;
      

      // temp = data['list'][0]['main']['temp'];
       
    } catch (e) {
      throw e.toString();
    }
      
  }

  @override
  Widget build(BuildContext context) {                                              //last-1 {
    return Scaffold(   
       resizeToAvoidBottomInset: true,
  
  
  //appbar begins............................................
  appBar: AppBar(                                                         
  backgroundColor: const Color.fromARGB(255, 1, 18, 28), // Set the background color for the AppBar
  title: SizedBox(
    width: 400.0, // Set width
    height: 40.0, //set height
    child: Container(
      decoration: BoxDecoration(                        //container for the input text field
        color: const Color.fromARGB(255, 7, 52, 74),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(                                     //childs in the serach bar are displayed as a row
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0), // Adjust the padding individually (left, top, right, bottom)
            child: Icon(                              //location icon
              Icons.location_on,
              color: Color.fromARGB(255, 49, 104, 159),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0), // Adjust the padding individually (left, top, right, bottom)
              child: TextField(                       //input text field
                controller: _cityController,    //new
                style: const TextStyle(color: Colors.white),
                // Your TextField properties and configurations
                decoration: const InputDecoration(
                  hintText: 'Search city',            //hint for the input text field
                  hintStyle: TextStyle(color: Color.fromARGB(255, 49, 104, 159)), // Color for the hint text
                  border: InputBorder.none, // Remove the underline
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0), // Adjust the padding
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 1.0, 10.0, 8.0), // Adjust the padding individually (left, top, right, bottom)
            child: IconButton(                
              onPressed: () {                 //when the search icon is pressed                     
                //FocusScope.of(context).unfocus(); //to close the keyboard
                String cityName = _cityController.text;  // Call the API with the entered city name
                if (cityName.isNotEmpty) {
                  getCurrentWeather(cityName).then((data) {
                    // Handle the response data
                    setState(() {});
                  }).catchError((error) {
                    // Handle errors
                    print(error);
                  });
                }
              },
              icon: const Icon(Icons.search, color: Color.fromARGB(255, 49, 104, 159)),
            ),
          ),
        ],
      ),
    ),
  ),
),
                                                                                //apppbar ends
      
      body: SingleChildScrollView(
      child: FutureBuilder(                                                      //last-3 (
        future: getCurrentWeather(_cityController.text),
        builder: (context , snapshot) {                                         //last-4 {
          print(snapshot);
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator()    //or use CircularProgressIndicator.adaptive()
              ) ;
          }
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString())
              );
          }



          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData ['main']['temp'].toInt();
          final currentSky =  currentWeatherData['weather'][0]['main'] ;
          final currentPressure = currentWeatherData ['main'] ['pressure'];
          final currentWindSpeed = currentWeatherData ['wind'] ['speed'];
          final currentHumidity = currentWeatherData ['main'] ['humidity'] ;

        
          return Padding(                                                         //last-5 (
          padding: const EdgeInsets.all(16.0),
          child: Column(                                                          //last-6 (
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [                                                           //last-7 [
              
              
              //first Card begins.....................................
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    ),
                  color: const Color.fromARGB(255, 2, 25, 35), // Set background color here
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                              Text(                       //tempurature
                                '$currentTemp°C',
                              style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              ),
                              const SizedBox(height: 16,),
                              Icon(
                                  currentSky == 'Clouds'
                                      ? Icons.cloud
                                      : (currentSky == 'Rain' ? Icons.shower_rounded : Icons.sunny),
                                  size: 100,
                                  color: Colors.white,
                                ),
                              const SizedBox(height: 4,),
                              Text(
                                  currentSky , 
                                  style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                          ],
                          ),
                      ),
                    ),
                  ),
                ),
              ),
              //first card ends.....................................


              
              const SizedBox(height: 45),



              //3rd card begins.....................................

              // const Text(
              //     'Additional Forcast' ,  style: TextStyle(
              //       fontSize: 24,
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
                const SizedBox(height: 10),
                Row(                                                              //row begins
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfo(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfo(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              //3rd card ends............................................
              
              const SizedBox(height: 45),


              //second card begins............................................
              const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Hourly Forcast',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
               
                const SizedBox(height: 10),
              
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){  
                    final hourlyForecast = data['list'] [index +1];
                    final hourlySky = data['list'] [index+1] ['weather'][0]['main'];
                    final hourlyTemp = hourlyForecast ['main'] ['temp'].toString();
                    final time = DateTime.parse(hourlyForecast ['dt_txt']);
                    return HourlyForcast(
                      time: DateFormat.Hm().format(time), 
                      temperature: hourlyTemp ,
                       icon: hourlySky == 'Clouds' ? Icons.cloud :
                             hourlySky == 'Rain' ? Icons.shower_rounded :
                              Icons.sunny,   
                    );
                  },
                ),
              ),
              //second card ends............................................

              
                                                                                    //row ends
              ],
             ),
           );
          },
        ),
      ),
    );
  }
}