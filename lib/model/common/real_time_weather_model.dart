class RealTimeWeatherModel {
  String status;
  String apiVersion;
  String apiStatus;
  String lang;
  String unit;
  num tzshift;
  String timezone;
  num serverTime;
  List<num> location;
  Result result;

  RealTimeWeatherModel(
      {this.status,
      this.apiVersion,
      this.apiStatus,
      this.lang,
      this.unit,
      this.tzshift,
      this.timezone,
      this.serverTime,
      this.location,
      this.result});

  RealTimeWeatherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    apiVersion = json['api_version'];
    apiStatus = json['api_status'];
    lang = json['lang'];
    unit = json['unit'];
    tzshift = json['tzshift'];
    timezone = json['timezone'];
    serverTime = json['server_time'];
    location = json['location'].cast<num>();
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['api_version'] = this.apiVersion;
    data['api_status'] = this.apiStatus;
    data['lang'] = this.lang;
    data['unit'] = this.unit;
    data['tzshift'] = this.tzshift;
    data['timezone'] = this.timezone;
    data['server_time'] = this.serverTime;
    data['location'] = this.location;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  Realtime realtime;
  num primary;

  Result({this.realtime, this.primary});

  Result.fromJson(Map<String, dynamic> json) {
    realtime = json['realtime'] != null
        ? new Realtime.fromJson(json['realtime'])
        : null;
    primary = json['primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.realtime != null) {
      data['realtime'] = this.realtime.toJson();
    }
    data['primary'] = this.primary;
    return data;
  }
}

class Realtime {
  String status;
  num temperature;
  num humidity;
  num cloudrate;
  String skycon;
  num visibility;
  num dswrf;
  Wind wind;
  num pressure;
  num apparentTemperature;
  Precipitation precipitation;
  AirQuality airQuality;
  LifeIndex lifeIndex;

  Realtime(
      {this.status,
      this.temperature,
      this.humidity,
      this.cloudrate,
      this.skycon,
      this.visibility,
      this.dswrf,
      this.wind,
      this.pressure,
      this.apparentTemperature,
      this.precipitation,
      this.airQuality,
      this.lifeIndex});

  Realtime.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    cloudrate = json['cloudrate'];
    skycon = json['skycon'];
    visibility = json['visibility'];
    dswrf = json['dswrf'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    pressure = json['pressure'];
    apparentTemperature = json['apparent_temperature'];
    precipitation = json['precipitation'] != null
        ? new Precipitation.fromJson(json['precipitation'])
        : null;
    airQuality = json['air_quality'] != null
        ? new AirQuality.fromJson(json['air_quality'])
        : null;
    lifeIndex = json['life_index'] != null
        ? new LifeIndex.fromJson(json['life_index'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['cloudrate'] = this.cloudrate;
    data['skycon'] = this.skycon;
    data['visibility'] = this.visibility;
    data['dswrf'] = this.dswrf;
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    data['pressure'] = this.pressure;
    data['apparent_temperature'] = this.apparentTemperature;
    if (this.precipitation != null) {
      data['precipitation'] = this.precipitation.toJson();
    }
    if (this.airQuality != null) {
      data['air_quality'] = this.airQuality.toJson();
    }
    if (this.lifeIndex != null) {
      data['life_index'] = this.lifeIndex.toJson();
    }
    return data;
  }
}

class Wind {
  num speed;
  num direction;

  Wind({this.speed, this.direction});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['direction'] = this.direction;
    return data;
  }
}

class Precipitation {
  Local local;
  Nearest nearest;

  Precipitation({this.local, this.nearest});

  Precipitation.fromJson(Map<String, dynamic> json) {
    local = json['local'] != null ? new Local.fromJson(json['local']) : null;
    nearest =
        json['nearest'] != null ? new Nearest.fromJson(json['nearest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.local != null) {
      data['local'] = this.local.toJson();
    }
    if (this.nearest != null) {
      data['nearest'] = this.nearest.toJson();
    }
    return data;
  }
}

class Local {
  String status;
  String datasource;
  num numensity;

  Local({this.status, this.datasource, this.numensity});

  Local.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    datasource = json['datasource'];
    numensity = json['numensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['datasource'] = this.datasource;
    data['numensity'] = this.numensity;
    return data;
  }
}

class Nearest {
  String status;
  num distance;
  num numensity;

  Nearest({this.status, this.distance, this.numensity});

  Nearest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    distance = json['distance'];
    numensity = json['numensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['distance'] = this.distance;
    data['numensity'] = this.numensity;
    return data;
  }
}

class AirQuality {
  num pm25;
  num pm10;
  num o3;
  num so2;
  num no2;
  num co;
  Aqi aqi;
  Description description;

  AirQuality(
      {this.pm25,
      this.pm10,
      this.o3,
      this.so2,
      this.no2,
      this.co,
      this.aqi,
      this.description});

  AirQuality.fromJson(Map<String, dynamic> json) {
    pm25 = json['pm25'];
    pm10 = json['pm10'];
    o3 = json['o3'];
    so2 = json['so2'];
    no2 = json['no2'];
    co = json['co'];
    aqi = json['aqi'] != null ? new Aqi.fromJson(json['aqi']) : null;
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pm25'] = this.pm25;
    data['pm10'] = this.pm10;
    data['o3'] = this.o3;
    data['so2'] = this.so2;
    data['no2'] = this.no2;
    data['co'] = this.co;
    if (this.aqi != null) {
      data['aqi'] = this.aqi.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description.toJson();
    }
    return data;
  }
}

class Aqi {
  num chn;
  num usa;

  Aqi({this.chn, this.usa});

  Aqi.fromJson(Map<String, dynamic> json) {
    chn = json['chn'];
    usa = json['usa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chn'] = this.chn;
    data['usa'] = this.usa;
    return data;
  }
}

class Description {
  String usa;
  String chn;

  Description({this.usa, this.chn});

  Description.fromJson(Map<String, dynamic> json) {
    usa = json['usa'];
    chn = json['chn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usa'] = this.usa;
    data['chn'] = this.chn;
    return data;
  }
}

class LifeIndex {
  Ultraviolet ultraviolet;
  Ultraviolet comfort;

  LifeIndex({this.ultraviolet, this.comfort});

  LifeIndex.fromJson(Map<String, dynamic> json) {
    ultraviolet = json['ultraviolet'] != null
        ? new Ultraviolet.fromJson(json['ultraviolet'])
        : null;
    comfort = json['comfort'] != null
        ? new Ultraviolet.fromJson(json['comfort'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ultraviolet != null) {
      data['ultraviolet'] = this.ultraviolet.toJson();
    }
    if (this.comfort != null) {
      data['comfort'] = this.comfort.toJson();
    }
    return data;
  }
}

class Ultraviolet {
  num index;
  String desc;

  Ultraviolet({this.index, this.desc});

  Ultraviolet.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['desc'] = this.desc;
    return data;
  }
}
