import utm
import json
import pyproj

WATER_SOURCE_DATA = "./ground/services/watersource_data.json"

class PoiService():
    pass

class WaterSourceService(PoiService):

    def __init__(self,
                 data_source: str):
        self._data_source = data_source
        self.data = None

    def read_data(self):
        with open(self._data_source, "r") as f:
            data = json.load(f)
            data = data["features"]
        return data
    
    # check if the distance between the two points is less than the radius in meters
    def _is_in_range(self, watersource_coords_in_utm, pos_coords_in_longlat, radius_meter):
        # convert to utm
        utm_watersource_coords = (watersource_coords_in_utm[0], watersource_coords_in_utm[1])
        utm_pos_coords = utm.from_latlon(pos_coords_in_longlat[0], pos_coords_in_longlat[1])
        # calculate distance
        distance = ((utm_watersource_coords[0] - utm_pos_coords[0]) ** 2 + (utm_watersource_coords[1] - utm_pos_coords[1]) ** 2) ** 0.5
        return distance <= radius_meter
        
        

    def get_water_sources(self, longitude: float, latitude: float, radius_meter: float = 100):
        if not self.data:
            self.data = self.read_data()
        
        for water_source in self.data:
            watersource_coords = water_source["geometry"]["coordinates"]
            if self._is_in_range(watersource_coords, [longitude, latitude], radius_meter):
                yield water_source



class WaterSourceServiceTest():

    def __init__(self):
        self._water_source_service = WaterSourceService(
            data_source=WATER_SOURCE_DATA
        )

    def test_get_water_sources(self):
        water_sources = self._water_source_service.get_water_sources(
            longitude=52.530628,
            latitude=13.409779,
            radius_meter=100
        )
        for water_source in water_sources:
            print(water_source)

    def test_get_water_sources_2(self):
        water_sources = self._water_source_service.get_water_sources(
            longitude=48.135589,
            latitude=11.576414,
            radius_meter=100
        )
        for water_source in water_sources:
            print(water_source)

    def test_get_water_sources_3(self):
        water_sources = self._water_source_service.get_water_sources(
            longitude=48.125082,
            latitude=11.582158,
            radius_meter=200
        )
        for water_source in water_sources:
            print(water_source)

WaterSourceServiceTest().test_get_water_sources_3()