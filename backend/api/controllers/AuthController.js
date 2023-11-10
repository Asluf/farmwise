const { Farmer } = require("../models/FarmerModel");
const { User } = require("../models/UserModel");
const { Investor } = require("../models/InvestorModel");
const { Buyer } = require("../models/BuyerModel");

//done
exports.registerFarmer = (req, res) => {
  const user = new Farmer(req.body);

  user
    .save()
    .then(() => {
      const log = new User({
        email: req.body.email,
        password: req.body.password,
        role: "farmer",
        profile_pic: req.body.profile_pic,
      });
      log
        .save()
        .then(() => {
          return res.status(200).json({
            success: true,
            message: "Successfully Signed Up!",
          });
        })
        .catch((err) => {
          return res.status(422).json({
            success: false,
            message: "Please enter unique nic & mobile no & email!",
            data: err,
          });
        });
    })
    .catch((err) => {
      return res.status(422).json({
        success: false,
        message: "Please enter unique nic & mobile no & email!",
        data: err,
      });
    });
};
exports.registerInvestor = (req, res) => {
  const user = new Investor(req.body);

  user
    .save()
    .then(() => {
      const log = new User({
        email: req.body.email,
        password: req.body.password,
        role: "investor",
        profile_pic: req.body.profile_pic,
      });
      log
        .save()
        .then(() => {
          return res.status(200).json({
            success: true,
            message: "Successfully Signed Up!",
          });
        })
        .catch((err) => {
          return res.status(422).json({
            success: false,
            message: "Please enter unique nic & mobile no & email!",
            data: err,
          });
        });
    })
    .catch((err) => {
      return res.status(422).json({
        success: false,
        message: "Please enter unique nic & mobile no & email!",
        data: err,
      });
    });
};
exports.registerBuyer = (req, res) => {
  const user = new Buyer(req.body);

  user
    .save()
    .then(() => {
      const log = new User({
        email: req.body.email,
        password: req.body.password,
        role: "buyer",
        profile_pic: req.body.profile_pic,
      });
      log
        .save()
        .then(() => {
          return res.status(200).json({
            success: true,
            message: "Successfully Signed Up!",
          });
        })
        .catch((err) => {
          return res.status(422).json({
            success: false,
            message: "Please enter unique nic & mobile no & email1!",
            data: err,
          });
        });
    })
    .catch((err) => {
      return res.status(422).json({
        success: false,
        message: "Please enter unique nic & mobile no & email2!",
        data: err,
      });
    });
};

exports.loginUser = (req, res) => {
  User.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        return res
          .status(404)
          .json({ success: false, message: "User email not found!" });
      } else {
        user.comparePassword(req.body.password, (err, isMatch) => {
          //isMatch is eaither true or false
          if (!isMatch) {
            return res.status(400).json({
              success: false,
              message: "Your password is wrong. Please check again!",
            });
          } else {
            user.generateToken((err, token) => {
              if (err) {
                return res.status(400).send({ success: false, message: err });
              } else {
                res.status(200).json({
                  success: true,
                  message: `Successfully Logged In`,
                  data: {
                    token: token,
                    role: user.role,
                    email:user.email
                  },
                });
              }
            });
          }
        });
      }
    })
    .catch((err) => {
      return res.status(200).json({
        success: true,
        message: "Login attempt failed!",
        data: err,
      });
    });
};



exports.uploadDpImage = (req, res,next) => {
  // upload.single('image')(req, res, (err) => {
  //   if (err) {
  //     res.status(500).json({ error: 'Image upload failed' });
  //   } else {
  //     res.status(200).json({ message: 'Image uploaded successfully' });
  //   }
  // });
  res.status(200).json({ message: `Image uploaded successfully${req.file.path}` });
};


exports.getUserDetails = (req, res) => {
  res.json({ status: true, message: "User Received!", data: req.user });
};
