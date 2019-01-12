var provider = new firebase.auth.GoogleAuthProvider();

// Get a reference to the database service
var database = firebase.database();

function logIn() {

  firebase.auth().signInWithPopup(provider).then(function (result) {
    // This gives you a Google Access Token. You can use it to access the Google API.
    var token = result.credential.accessToken;
    // The signed-in user info.
    var user = result.user;
    // ...
  }).catch(function (error) {
    // Handle Errors here.
    var errorCode = error.code;
    var errorMessage = error.message;
    // The email of the user's account used.
    var email = error.email;
    // The firebase.auth.AuthCredential type that was used.
    var credential = error.credential;
    // ...
  });
}
function logOut() {
  firebase.auth().signOut().then(function () {
    // Sign-out successful.
  }).catch(function (error) {
    // An error happened.
  });
}

function saveCountry() {
  if (!!firebase.auth().currentUser) {
    info = document.getElementById("country_in").value;
    var curerentUserName = firebase.auth().currentUser.displayName;
    var picture = firebase.auth().currentUser.photoURL;
    var infoList = info.split(',');


    for (var i = 0; i < infoList.length; i++) {
      console.log(infoList[i]);
      firebase.database().ref('countries/' + infoList[i].trim()).set({
        username: curerentUserName,
        profile_pictue: picture
      });
    }

  } else {
    alert("Please sign in")
  }
}

function gettingCountry() {
  //here you can implements the code you get the name of the countries in your firebase realtime database.
  //notes: don't forget to call the function "displayMessages(key,text)" with the right parameters
  //otherWise the site won't show the countries
  //another note: you have to call the firebase listener always ON change and ON add of an item.

}




//auxiliar functions try take a look if you get what happens

function authStateObserver(user) {
  if (user) { // User is signed in!
    // Get the signed-in user's profile pic and name.
    var profilePicUrl = getProfilePicUrl();
    var userNameLocal = getUserName();

    // Set the user's profile pic and name.
    if (profilePicUrl) {
      userPic.style.backgroundImage = 'url(' + profilePicUrl + ')';
      userPic.removeAttribute('hidden');
    }
    userName.value = userNameLocal;

    // Show user's profile and sign-out button.
    userName.removeAttribute('hidden');

    out.removeAttribute('hidden');

    // Hide sign-in button.
    inn.setAttribute('hidden', 'true');

  } else { // User is signed out!
    // Hide user's profile and sign-out button.
    userName.setAttribute('hidden', 'true');
    userPic.setAttribute('hidden', 'true');
    out.setAttribute('hidden', 'true');

    // Show sign-in button.
    inn.removeAttribute('hidden');
  }
}


function initFirebaseAuth() {
  // Listen to auth state changes.
  firebase.auth().onAuthStateChanged(authStateObserver);
}

// Returns the signed-in user's profile Pic URL.
function getProfilePicUrl() {
  return firebase.auth().currentUser.photoURL;
}

// Returns the signed-in user's display name.
function getUserName() {
  return firebase.auth().currentUser.displayName;
}

// Returns true if a user is signed-in.
function isUserSignedIn() {
  return !!firebase.auth().currentUser;
}

function displayMessage(key, text) {
  var container = document.getElementById(key);
  // If an element for that message does not exists yet we create it.
  if (!container) {
    container = document.createElement('li');
    container.setAttribute('id', key);
    container.setAttribute('class', "collection-item");
    collection.appendChild(container);
  }
  container.innerText = text;

}

//getting pages elements
var userPic = document.getElementById('pic');
var userName = document.getElementById('nome');
var signInBtn = document.getElementById('login-button');
var signOutBtn = document.getElementById('logout-button');
var collection = document.getElementById('myout');
var send = document.getElementById("send-button");
var info = document.getElementById("country_in").value;
var inn = document.getElementById("in");
var out = document.getElementById('out');

//adding listeners
signInBtn.addEventListener('click', logIn);
signOutBtn.addEventListener('click', logOut);
send.addEventListener("click", saveCountry);
//calling functions that are listeners
initFirebaseAuth();

gettingCountry();