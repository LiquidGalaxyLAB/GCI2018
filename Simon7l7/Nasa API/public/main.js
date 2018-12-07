var image = document.images[0];
var text = document.getElementsByTagName("P")
var urls = []
var imageData = [];
var currentId = 0;
var loopCount = 0;
var interval = setInterval(loop, 800);
loop();

function loop() {
    currentId++;
    if (currentId <= 12) {
        if (loopCount == 0) {
            findimages("2016-" + pad(currentId) + "-20", currentId);
        } else {
            nextimage(urls[currentId]);
            if (loopCount == 1) {
                text[0].innerHTML = "Please Wait, Downloading Image: " + imageData[currentId].date;
            } else {
                text[0].innerHTML = "Date and Time: " + imageData[currentId].date;
            }
        }
    } else {
        loopCount++;
        currentId = 0;
    }
    return 0;
}

function pad(number) {
    return (number < 10 ? "0" : "") + number
}

function findimages(imageDate, imageId) {
    fetch("https://api.nasa.gov/planetary/earth/imagery/?lon=138.6007&lat=-34.9285&date=" + imageDate + "&dim=0.1&cloud_score=True&api_key="API KEY HERE"")
        .then(res => res.json())
        .then((out) => {
            urls[imageId] = out.url;
            imageData[imageId] = out;
        }).catch(err => console.error(err));
}

function nextimage(imageSource) {
    var newImage = new Image();
    newImage.src = imageSource;
    image.src = newImage.src;
}
