import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main () => runApp(
  MaterialApp(
    title: "Weather App",
    home: Home(),
  )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather () async {
    String url ='http://api.openweathermap.org/data/2.5/weather?lat=65.014167&lon=25.471944&units=metric&appid=2b1f6db2f08eda09d97232ddeaa34887';
    http.Response response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState () {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
            color: Colors.lightGreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Currently in Oulu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
              Text(
                temp != null ? temp.toString() + "52\u00B0" + "C" : "Loading",
                style: TextStyle(
                  color: Colors.white,
                      fontSize: 40.0,
                    fontWeight: FontWeight.w600
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  currently != null ? currently.toString() : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
            ),
          ),
          Expanded(
            child: Padding(
             padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget> [
                  ListTile(
                    leading: Icon(Icons.whatshot),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0" + "C" : "Loading"),
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null ? description.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: Icon(Icons.wb_sunny),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() + "%" : "Loading"),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_forward),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() + " m/s": "Loading"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

