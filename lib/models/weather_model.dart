class Weather {

  final String cityName;
  final double tempreture;
  final String mainCondition;
 


  Weather({
    required this.cityName,required this.mainCondition, required this.tempreture
});


  factory Weather.fromJson(Map<String, dynamic> json){

    return Weather(cityName: json['name'], mainCondition: json['weather'][0]['main'], tempreture: json['main']['temp'].toDouble());
  }
}