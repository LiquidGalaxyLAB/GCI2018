using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Timelapse
{
    class Program
    {
        private static string _imageTempFolder = @"C:\Users\USER\Pictures\TempImgFolder\"; //Specify image output path in order to work
        static void Main(string[] args)
        {
            string path = "";
            for (int i = 1; i < 13; i++)
            {
                string result = GetImageUrl(52.229676f, 21.012229f, 0.025f, new DateTime(2016, i, 1), false, "yourApiKey");
                path = _imageTempFolder + string.Format("img{0}.png", i);
                DownloadImage(result, path);
                Console.WriteLine("Downloading photo: " + i);
            }
            for (int i = 1; i < 13; i++)
            {
                path = _imageTempFolder + string.Format("img{0}.png", i);
                OpenImage(path);
            }

            Console.ReadKey();
        }

        private static string GetImageUrl(float lat, float lon, float dim, DateTime date, bool cloud_score, string apiKey)
        {
            string formattedDate = date.ToString("yyyy-MM-dd");
            string url = "https://api.nasa.gov/planetary/earth/imagery/?";
            string parameters = string.Format("lon={0}&lat={1}&dim={2}&date={3}&cloud_score={4}&api_key={5}", lon, lat, dim, formattedDate, cloud_score, apiKey);
            using (WebClient client = new WebClient())
            {
                var responseString = client.DownloadString(url + parameters);
                var data = (JObject)JsonConvert.DeserializeObject(responseString);
                string imageUrl = data["url"].Value<string>();
                return imageUrl;
            }
        }

        private static void DownloadImage(string url, string path)
        {
            using (WebClient client = new WebClient())
            {
                client.DownloadFile(url, path);
            }
        }

        private static void OpenImage(string path)
        {
            System.Threading.Thread.Sleep(1000);
            Process.Start(path);
        }

    }
}