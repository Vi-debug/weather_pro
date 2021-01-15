class OtherInfo {
  final num fellLikeTemp;
  final num humidity;
  final num windDirection;
  final num windSpeed;
  final num visibility;
  final num uV;

  OtherInfo(
      {this.uV,
      this.fellLikeTemp,
      this.humidity,
      this.windDirection,
      this.windSpeed,
      this.visibility});

  OtherInfo.fromJson(Map<String, dynamic> json)
      : fellLikeTemp = json['feels_like'].round(),
        humidity = json['humidity'],
        windDirection = json['wind_deg'],
        uV = json['uvi'],
        visibility = json['visibility'],
        windSpeed = json['wind_speed'];
}
