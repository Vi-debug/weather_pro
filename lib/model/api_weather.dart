class ApiWeather {
    static const ApiKey = 'dfead8a8da2f58d80d6871874dcc7b94';

    final double latitude;
    final double longitude;

    ApiWeather(this.latitude, this.longitude);

    String getUrlTemp() =>  "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&lang=vi&appid=$ApiKey";

    String getUrlAir() => "http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$ApiKey";

    String getUrlNextDay() => "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&lang=vi&appid=$ApiKey";
}
