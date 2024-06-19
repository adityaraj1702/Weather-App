class CityData {
  String? city;
  String? lat;
  String? lon;
  String? tempC;
  String? maxtempC;
  String? mintempC;
  String? avgtempC;
  String? tempF;
  String? maxtempF;
  String? mintempF;
  String? avgtempF;
  String? feelslikeC;
  String? feelslikeF;
  String? localtime;
  String? weatherCondition;
  String? windSpeedKph;
  String? windSpeedMph;
  String? humidity;
  String? aqi;
  String? chanceofrain;

  CityData(
      {this.city,
      this.tempC,
      this.lat,
      this.lon,
      this.maxtempC,
      this.mintempC,
      this.avgtempC,
      this.tempF,
      this.maxtempF,
      this.mintempF,
      this.avgtempF,
      this.feelslikeC,
      this.feelslikeF,
      this.localtime,
      this.weatherCondition,
      this.windSpeedKph,
      this.windSpeedMph,
      this.humidity,
      this.aqi,
      this.chanceofrain});

  CityData.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    lat = json['lat'];
    lon = json['lon'];
    tempC = json['temp_c'];
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    avgtempC = json['avgtemp_c'];
    tempF = json['temp_f'];
    maxtempF = json['maxtemp_f'];
    mintempF = json['mintemp_f'];
    avgtempF = json['avgtemp_f'];
    feelslikeC = json['feelslike_c'];
    feelslikeF = json['feelslike_f'];
    localtime = json['localtime'];
    weatherCondition = json['weatherCondition'];
    windSpeedKph = json['windSpeed_kph'];
    windSpeedMph = json['windSpeed_mph'];
    humidity = json['humidity'];
    aqi = json['aqi'];
    chanceofrain = json['chanceofrain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['lat'] = lat;
    data['lon'] = lon;
    data['temp_c'] = tempC;
    data['maxtemp_c'] = maxtempC;
    data['mintemp_c'] = mintempC;
    data['avgtemp_c'] = avgtempC;
    data['temp_f'] = tempF;
    data['maxtemp_f'] = maxtempF;
    data['mintemp_f'] = mintempF;
    data['avgtemp_f'] = avgtempF;
    data['feelslike_c'] = feelslikeC;
    data['feelslike_f'] = feelslikeF;
    data['localtime'] = localtime;
    data['weatherCondition'] = weatherCondition;
    data['windSpeed_kph'] = windSpeedKph;
    data['windSpeed_mph'] = windSpeedMph;
    data['humidity'] = humidity;
    data['aqi'] = aqi;
    data['chanceofrain'] = chanceofrain;
    return data;
  }
}
