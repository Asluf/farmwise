var mongoose = require('mongoose');
var bcrypt = require('bcrypt');
require("dotenv").config();
const jwt = require('jsonwebtoken');
const UserRole = require('../enums/UserRole');

const SALT = 10;
var Schema = mongoose.Schema;
var UserSchema = new Schema({
    email: {
        type: String,
        required: [true, 'Email field is required!'],
        maxlength: 100,
        unique: true
    },
    password: {
        type: String,
        required: [true, 'Password field is required!'],
        maxlength: 100,
    },
    role: {
        type: String,
        maxlength: 100,
    },
    profile_pic: {
        type: String,
        maxlength: 200,
        default: ''
    },
    created_date: {
        type: Date,
        maxlength: 200,
        default: Date.now
    }
});

// Saving user data
UserSchema.pre('save', function (next) {
    var user = this;
    if (user.isModified('password')) {
        //checking if password field is available and modified
        bcrypt.genSalt(SALT, function (err, salt) {
            if (err) return next(err)
        
            bcrypt.hash(user.password, salt, function (err, hash) {
                if (err) return next(err)
                user.password = hash;
                next();
            });
        });
    } else {
        next();
    }
});
     
// For comparing the users entered password with database during login 
UserSchema.methods.comparePassword = function (candidatePassword, callBack) {
    bcrypt.compare(candidatePassword, this.password, function (err, isMatch) {
        if (err) return callBack(err);
        callBack(null, isMatch);
    });
};

// For generating token when loggedin
UserSchema.methods.generateToken = function (callBack) {
    var user = this;
    var token = jwt.sign(user._id.toHexString(), process.env.SECRETE);
    
    callBack(null, token);
};

// Validating token for auth routes middleware
UserSchema.statics.findByToken = function (token, callBack) {
    jwt.verify(token, process.env.SECRETE, function (err, decode) {
        User.findById(decode).then((user) => {
            callBack(null, user);
        }).catch((err) => {
            callBack(err, null);
        });
    });
};

const User = mongoose.model('login_details', UserSchema);
module.exports = { User }