var mongoose = require("mongoose");
var bcrypt = require("bcrypt");
require("dotenv").config();

const SALT = 10;

var Schema = mongoose.Schema;

var ProProposalSchema = new Schema({
  farmer_email: {
    type: String,
    required: [true, "Farmer email field is required!"],
    maxlength: 100,
  },
  product_name: {
    type: String,
    required: [true, "Product Name field is required!"],
    maxlength: 200,
  },
  product_description: {
    type: String,
    maxlength: 400,
    default: "",
  },
  product_img_path: {
    type: String,
    required: [true, "Product image field is required!"],
    maxlength: 200,
  },
  quantity: {
    type: String,
    required: [true, "Quantity field is required!"],
    maxlength: 200,
  },
  unit_price: {
    type: String,
    required: [true, "Unit price field is required!"],
    maxlength: 20,
  },
  total_price: {
    type: String,
    required: [true, "Total price field is required!"],
    maxlength: 20,
  },
  produced_date: {
    type: Date,
    required: [true, "Produced date field is required!"],
    maxlength: 200,
  },
  expire_date: {
    type: Date,
    required: [true, "Expire date field is required!"],
    maxlength: 200,
  },
  buyer_email: {
    type: String,
    maxlength: 200,
    default: "",
  },
  product_status: {
    type: String,
    maxlength: 200,
    default: "available",
  },
  proposal_status: {
    type: String,
    maxlength: 200,
    default: "pending",
  },
  response: {
    type: String,
    maxlength: 200,
    default: "",
  },
  created_date: {
    type: Date,
    maxlength: 200,
    default: Date.now,
  },
});

const ProProposal = mongoose.model("product_proposals", ProProposalSchema);
module.exports = { ProProposal };
