var mongoose = require('mongoose');
var bcrypt = require('bcrypt');
require("dotenv").config();

const SALT = 10;

var Schema = mongoose.Schema;

var CulProposalSchema = new Schema({
    farmer_email: {
        type: String,
        required: [true, 'farmer_email field is required!'],
        maxlength: 100
    },
    crop_name: {
        type: String,
        required: [true, 'Crop Name field is required!'],
        maxlength: 200
    },
    crop_details: {
        type: String,
        maxlength: 400,
        default:""
    },
    duration: {
        type: String,
        required: [true, 'Duration field is required!'],
        maxlength: 200,
    },
    start_date: {
        type: Date,
        required: [true, 'Start date field is required!'],
        maxlength: 50,
    },
    acres: {
        type: String,
        required: [true, 'Acres field is required!'],
        maxlength: 200
    },
    total_amount: {
        type: String,
        required: [true, 'Total amount field is required!'],
        maxlength: 200
    },
    investment_of_farmer: {
        type: String,
        required: [true, 'Investment of farmer field is required!'],
        maxlength: 200
    },
    investment_of_investor: {
        type: String,
        required: [true, 'Investment of investor field is required!'],
        maxlength: 200
    },
    roi_farmer: {
        type: String,
        required: [true, 'ROI of farmer field is required!'],
        maxlength: 200
    },
    roi_investor: {
        type: String,
        required: [true, 'ROI of investor field is required!'],
        maxlength: 200
    },
    years_of_experience: {
        type: String,
        required: [true, 'Experience field is required!'],
        maxlength: 200
    },
    land_img_path: {
        type: String,
        required: [true, 'Land image field is required!'],
        maxlength: 200
    },
    proposal_status: {
        type: String,
        maxlength: 200,
        default: "pending"
    },
    investor_email: {
        type: String,
        maxlength: 200,
        default: ""
    },
    cultivation_status: {
        type: String,
        maxlength: 200,
        default: "pending"
    },
    created_date: {
        type: Date,
        maxlength: 200,
        default: Date.now
    }

});


const CulProposal = mongoose.model('cultivation_proposals', CulProposalSchema);
module.exports = { CulProposal }