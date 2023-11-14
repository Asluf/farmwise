const multer = require('multer');
const path = require("path");


// upload the profile image
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, 'uploads/profilepic/'); 
    },
    filename: (req, file, cb) => {
      let ext = path.extname(file.originalname)
      cb(null, Date.now()+ ext); 
    },
  });
  const upload = multer({ 
    storage:storage,
    fileFilter: function(req,file,callback){
        if(file.mimetype == "image/png" || file.mimetype == "image/jpg" || file.mimetype == "image/jpeg"|| file.mimetype == "image/heic" ||file.mimetype == "image/PNG" || file.mimetype == "image/JPG" || file.mimetype == "image/JPEG"|| file.mimetype == "image/HEIC"){
            callback(null,true);
        }else{
            console.log('File formats should be jpg, jpeg, png');
            callback(null, false);
        }
    }
});

module.exports = upload;