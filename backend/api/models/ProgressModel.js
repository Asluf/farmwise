var mongoose = require("mongoose");
var bcrypt = require("bcrypt");
require("dotenv").config();


var Schema = mongoose.Schema;

var ProgressSchema = new Schema({
  cultivation_id: {
    type: String,
    required: [true, "Cultivation id field is required!"],
    maxlength: 100,
    unique:true
  },
  farmer_email: {
    type: String,
    required: [true, "Farmer email field is required!"],
    maxlength: 200,
  },
  investor_email: {
    type: String,
    required: [true, "Investor email field is required!"],
    maxlength: 200,
  },
  created_date: {
    type: Date,
    maxlength: 200,
    default: Date.now,
  },
  img_paths: {
    img1: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date1: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img2: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date2: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img3: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date3: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img4: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date4: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img5: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date5: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img6: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date6: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img7: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date7: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img8: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date8: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img9: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date9: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img10: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date10: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img11: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date11: {
      type: Date,
      maxlength: 50,
      default: "",
    },
    img12: {
      type: String,
      maxlength: 200,
      default: "",
    },
    date12: {
      type: Date,
      maxlength: 50,
      default: "",
    },
  },
});

const Progress = mongoose.model("progresses", ProgressSchema);
module.exports = { Progress };
