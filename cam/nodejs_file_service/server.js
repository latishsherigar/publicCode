const express = require('express');



const app = express();

const app_root_path = "/home/admin/cam/nodejs_file_service/";

app.get('/', (req, res) => {
  //res.send('Hello from App Engine!');
  res.sendFile(app_root_path + "index.html");
});

app.get('/viewer.html', (req, res) => {
  //res.send('Hello from App Engine!');
  res.sendFile(app_root_path + "viewer.html");
});

// Listen to the App Engine-specified port, or 8080 otherwise
const PORT = 8080;

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}...`);
});


// This responds a GET request for the /ls page.
app.get('/ls*', function (req, res) {

  listFiles(req, res)
}
);


// This responds a GET request for the /getfile page.
app.get('/getfile*', function (req, res) {

  getFile(req, res)
}
);




//***************************** */


function listFiles(req, res) {
  console.log("Got a GET request for /ls");
  //res.send('Page Listing' + req.query.path);

  const cam = req.query.cam;
  const search_from_date = req.query.search_from_date;
  const search_to_date = req.query.search_to_date;
  const lsFolder = "/media/HD/cctv/" + cam + "/" + search_from_date.substr(0, 4) + "/" + search_from_date.substr(4, 2) + "/" + search_from_date.substr(6, 2);

  fs = require('fs');
  console.log('path - ' + lsFolder);
  console.log('search_from_date - ' + search_from_date);
  console.log('search_to_date - ' + search_to_date);

  const thefile = {
    name: "",
    path: "",
    isDirectory: false
  };

  var fileobjArr = [];

  const file_search_pattern = search_from_date

  var files = fs.readdirSync(lsFolder).filter(fn => fn.startsWith(search_from_date));



  files.forEach(file => {
    console.log(file);
    var fileobj = Object.create(thefile);
    fileobj.name = file;
    fileobjArr.push(fileobj);

  });

  res.send(JSON.stringify(fileobjArr));


}

function getFile(req, res) {
  const cam = req.query.cam;
  const filename= req.query.file;
  const filepath = "/media/HD/cctv/" + cam + "/" + filename.substr(0, 4) + "/" + filename.substr(4, 2) + "/" + filename.substr(6, 2);

  fs = require('fs');
  console.log('path - ' + filepath);
  console.log('file - ' + filename);

  res.sendFile(filepath+ "/" + filename);
 // fs.readFile( filepath+ "/" + filename, 'utf8', function(err, data){
      
  
  //console.log(data);
//});

 
}


