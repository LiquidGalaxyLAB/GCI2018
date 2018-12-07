'use strict';

// Import the Dialogflow module from the Actions on Google client library.
const {dialogflow,
       BasicCard,
       BrowseCarousel,
       BrowseCarouselItem,
       Button,
       Carousel,
       Image,
       LinkOutSuggestion,
       List,
       MediaObject,
       Suggestions,
       SimpleResponse
      } = require('actions-on-google');

// Import the firebase-functions package for deployment.
const functions = require('firebase-functions');

// Instantiate the Dialogflow client.
const app = dialogflow({debug: true});

//const { BasicCard, Suggestion } = require('dialogflow-fulfillment');



const fetch = require('node-fetch');

var data = {};

app.intent('locationIntent', (conv, {city}) => {
    const luckyNumber = city.length;
    // Respond with the user's lucky number and end the conversation.
    console.log("start");
  //conv.add('Your city is ' + city);
  //console.log("start2");

    
  
return new Promise(function (resolve, reject) {
    fetch('https://kgsearch.googleapis.com/v1/entities:search?query=' + encodeURIComponent(city) + '&key="API KEY HERE"&limit=1&indent=True', {
        method: 'GET'
    })
        .then(res => res.json())
        .then(json => {
            data = json.itemListElement[0].result;
            console.log(json.itemListElement[0].result.detailedDescription.articleBody);

            //conv.ask(json.itemListElement[0].result.detailedDescription.articleBody);
      conv.ask(new SimpleResponse({
  speech: json.itemListElement[0].result.detailedDescription.articleBody,
  text: city,
}));
      conv.ask(new BasicCard({
         title: city,
         text: json.itemListElement[0].result.detailedDescription.articleBody,
        image: new Image({
    url: json.itemListElement[0].result.image.contentUrl,
    alt: city,
  }),
        display: 'CROPPED',
       }));
			resolve()
        });
});  
  
});

    
// Set the DialogflowApp object to handle the HTTPS POST request.
exports.dialogflowFirebaseFulfillment = functions.https.onRequest(app);