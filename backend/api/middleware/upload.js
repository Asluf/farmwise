const multer = require("multer");
const path = require("path");

// upload the profile image
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/profilepic/");
  },
  filename: (req, file, cb) => {
    let ext = path.extname(file.originalname);
    cb(null, Date.now() + ext);
  },
});
exports.uploadDp = multer({
  storage: storage,
  fileFilter: function (req, file, callback) {
    if (
      file.mimetype == "image/png" ||
      file.mimetype == "image/jpg" ||
      file.mimetype == "image/jpeg" ||
      file.mimetype == "image/heic" ||
      file.mimetype == "image/PNG" ||
      file.mimetype == "image/JPG" ||
      file.mimetype == "image/JPEG" ||
      file.mimetype == "image/HEIC" ||
      file.mimetype == "application/octet-stream"
    ) {
      callback(null, true);
    } else {
      console.log("File formats should be jpg, jpeg, png");
      callback(null, false);
    }
  },
});


// upload cultivation proposal images
const storagecul = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/culproposal/");
  },
  filename: (req, file, cb) => {
    let ext = path.extname(file.originalname);
    cb(null, Date.now() + ext);
  },
});
exports.uploadCulPropoal = multer({
  storage: storagecul,
  fileFilter: function (req, file, callback) {
    
    if (
      file.mimetype == "image/png" ||
      file.mimetype == "image/jpg" ||
      file.mimetype == "image/jpeg" ||
      file.mimetype == "image/heic" ||
      file.mimetype == "image/PNG" ||
      file.mimetype == "image/JPG" ||
      file.mimetype == "image/JPEG" ||
      file.mimetype == "image/HEIC" ||
      file.mimetype == "application/octet-stream"
    ) {
      callback(null, true);
    } else {
      console.log("File formats should be jpg, jpeg, png");
      callback(null, false);
    }
  },
});

// upload Product proposal image
const storagepro = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/proproposal/");
  },
  filename: (req, file, cb) => {
    let ext = path.extname(file.originalname);
    cb(null, Date.now() + ext);
  },
});
exports.uploadProPropoal = multer({
  storage: storagepro,
  fileFilter: function (req, file, callback) {
    
    if (
      file.mimetype == "image/png" ||
      file.mimetype == "image/jpg" ||
      file.mimetype == "image/jpeg" ||
      file.mimetype == "image/heic" ||
      file.mimetype == "image/PNG" ||
      file.mimetype == "image/JPG" ||
      file.mimetype == "image/JPEG" ||
      file.mimetype == "image/HEIC" ||
      file.mimetype == "application/octet-stream"
    ) {
      callback(null, true);
    } else {
      console.log("File formats should be jpg, jpeg, png");
      callback(null, false);
    }
  },
});


