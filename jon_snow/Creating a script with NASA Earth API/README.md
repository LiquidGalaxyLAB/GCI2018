Since the api also had the additional facility of reporting the cloudscore of a particular place, I have also included functionality which allows you to filter on the basis of a cloud score. The script takes in the following arguments:
1. --latitude= latitude of the place
2. --longitude=longitude of the place
3. --start=Starting date in form YYYY-MM-DD
4. --end=Ending date in form YYYY-MM-DD
5. --interval=Interval at which pictures are to be downloaded
6. --apikey=NASA API key
7. --clouds = Incude clouds in timelapse? Defaults to false 
8. --cloudscore=Maximum value for cloudscore to include in timelapse, default = 0.1, maximum = 1.0
9. --duration=Duration of one picture in the resulting gif

you can get an api key from here: https://api.nasa.gov/index.html#apply-for-an-api-key
