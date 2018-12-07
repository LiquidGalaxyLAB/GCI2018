var imageData = {};

document.getElementById("button1").addEventListener("click", function () { findaddress("data1"); });
document.getElementById("button2").addEventListener("click", function () { findaddress("data2"); });
document.getElementById("button3").addEventListener("click", function () { findaddress("data3"); });
document.getElementById("button4").addEventListener("click", function () { findaddress("data4"); });
document.getElementById("button5").addEventListener("click", function () { findaddress("data5"); });
document.getElementById("button6").addEventListener("click", function () { findaddress("data6"); });


function findaddress(id) {
    var placeName = document.getElementById(id).value;
    document.getElementById("img" + "min" + id).src = "/dots.gif";
    document.getElementById("img" + "max" + id).src = "/dots.gif";
    if (placeName) {
        fetch("https://us1.locationiq.com/v1/search.php?key="API KEY HERE 2"&q=" + placeName + "&format=json&limit=1")
            .then(res => res.json())
            .then((out) => {
                imageData[placeName] = out[0];
                findTimes(placeName, imageData[placeName]["lat"], imageData[placeName]["lon"], id);
            }).catch(err => console.error(err));
    }
}
function findTimes(placeName, lat, lon, id) {
    var maxdate = new Date(0);
    var mindate = new Date();
    var dates = [];
    fetch("https://api.nasa.gov/planetary/earth/assets?lon=" + lon + "&lat=" + lat + "&begin=1900-01-01&api_key="API KEY HERE"")
        .then(res => res.json())
        .then((out) => {
            for (var i = 0; i < out.count; i++) {
                dates[i] = new Date(out["results"][i]["date"]);
                console.log(dates[i]);
                if (dates[i] > maxdate) {
                    maxdate = dates[i];
                }
                if (dates[i] < mindate) {
                    mindate = dates[i];
                }
                imageData[placeName] = {};
                imageData[placeName]["mindate"] = mindate;
                imageData[placeName]["maxdate"] = maxdate;
            }
            findimages(mindate.toISOString().split('T')[0], "min", placeName, lat, lon, id);
            findimages(maxdate.toISOString().split('T')[0], "max", placeName, lat, lon, id);
            document.getElementById("text" + id).innerHTML = mindate.toISOString().split('T')[0] + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" + maxdate.toISOString().split('T')[0];
        }).catch(err => console.error(err));
}
function findimages(imageDate, imageId, placeName, lat, lon, id) {
    fetch("https://api.nasa.gov/planetary/earth/imagery/?lon=" + lon + "&lat=" + lat + "&date=" + imageDate + "&dim=0.125&cloud_score=True&api_key=DUIQSpBODjuaYiSQXZ9rC8AOM2ab5VVyLu23XK8W")
        .then(res => res.json())
        .then((out) => {
            imageData[placeName][imageId] = out;
            document.getElementById("img" + imageId + id).src = out.url;
        }).catch(err => console.error(err));
}