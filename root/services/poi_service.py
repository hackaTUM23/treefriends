import logging
import utm
import json
from Datamodel.Location import location

from services.watersource import Watersource

class PoiService():
    pass

class WaterSourceService(PoiService):

    def __init__(self,
                 data_source: str):
        self._data_source = data_source
        self.data = None

    def _read_data(self):
        with open(self._data_source, "r") as f:
            data = json.load(f)
            data = data["features"]
        return data
    
    # check if the distance between the two points is less than the radius in meters
    def _is_in_range(self, watersource_coords_in_utm, pos_coords_in_longlat, radius_meter):
        # convert to utm
        utm_watersource_coords = (watersource_coords_in_utm[0], watersource_coords_in_utm[1])
        utm_pos_coords = utm.from_latlon(pos_coords_in_longlat[0], pos_coords_in_longlat[1])
        logging.debug(f"Converted to utm: {utm_watersource_coords}, {utm_pos_coords}")
        # calculate distance
        distance = ((utm_watersource_coords[0] - utm_pos_coords[0]) ** 2 + (utm_watersource_coords[1] - utm_pos_coords[1]) ** 2) ** 0.5
        return distance <= radius_meter
        
        

    def get_water_sources(self, latitude: float, longitude: float, radius_meter: float = 200):
        logging.debug(f"Getting water sources for location: {latitude}, {longitude}")
        if not self.data:
            self.data = self._read_data()
        
        for water_source in self.data:
            watersource_coords = water_source["geometry"]["coordinates"]
            logging.debug(f"Checking water source: {utm.to_latlon(watersource_coords[0], watersource_coords[1], 32, 'U')}")
            if self._is_in_range(watersource_coords, [longitude, latitude], radius_meter):
                loc = location(*utm.to_latlon(watersource_coords[0], watersource_coords[1], 32, "U"))
                logging.debug(f"Found water source: {location}")
                yield Watersource(loc).to_json() 
