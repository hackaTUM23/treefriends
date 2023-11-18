from datetime import datetime as dt

from matplotlib import pyplot as plt
from meteostat import Daily, Point, Monthly, Stations


class WeatherService:

    def __init__(self,
                 longitude: float,
                 latitude: float):
        self._location = Point(lat=latitude, lon=longitude)
        stations = Stations()
        stations = stations.nearby(lat=latitude, lon=longitude)
        station = stations.fetch(1)
        print(station)
    
    def get_weather_for_day(self, start:dt, end:dt):
        data = Daily(start=start, end=end, loc=self._location)
        return data.fetch()
    
    def plot_weather(self, data):
        data.plot(y=['tavg', 'tmin', 'tmax', 'prcp'])
        plt.show()

    def day_last_rain(self):
        now = dt.now()
        #now minus one year
        last_year = now.replace(year=now.year-1)
        one_year_data = self.get_weather_for_day(last_year,now)
        #get last rain
        last_rain = one_year_data[one_year_data['prcp'] > 0].iloc[-1]
        amount_rain = last_rain['prcp']
        #format timestamp
        last_rain = last_rain.name.strftime("%d.%m.%Y")
        return last_rain, amount_rain
        
    def day_next_rain(self):
        now = dt.now()
        #now plus two weeks
        next_two_weeks = now.replace(year=now.year+1, month=now.month, day=now.day)
        two_weeks_data = self.get_weather_for_day(now,next_two_weeks)
        #get next rain
        next_rain = two_weeks_data[two_weeks_data['prcp'] > 0].iloc[0]
        amount_rain = next_rain['prcp']
        next_rain = next_rain.name.strftime("%d.%m.%Y")
        return next_rain, amount_rain


class WeatherServiceTest():

    def __init__(self):
        self._weather_service = WeatherService(
            longitude=11.582158,
            latitude=48.125082,
        )

    def test_get_weather_for_day(self):
        data = self._weather_service.get_weather_for_day(dt(2023, 11, 17),dt(2023, 11, 23))
        print(data)
        self._weather_service.plot_weather(data)

    def test_day_last_rain(self):
        last_rain = self._weather_service.day_last_rain()
        print(last_rain)

    def test_day_next_rain(self):
        next_rain = self._weather_service.day_next_rain()
        print(next_rain)

print(WeatherServiceTest().test_day_next_rain())