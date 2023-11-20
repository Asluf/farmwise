const { Investor } = require("../models/InvestorModel");
const { User } = require("../models/UserModel");

exports.getInvestor = (req, res) => {
  Investor.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        return res
          .status(404)
          .json({ success: false, message: "User email not found!" });
      } else {
        User.findOne({ email: req.body.email }, "profile_pic").then(
          (loginDetails) => {
            if (!loginDetails) {
              return res
                .status(404)
                .json({ success: false, message: "User email not found!" });
            } else {
              return res.status(200).json({
                success: true,
                message: `Investor found`,
                data: user,
                dpDetails: loginDetails,
              });
            }
          }
        );
      }
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};

exports.editInvestor = (req, res) => {
  const updateData = {
    investor_name: req.body.investor_name,
    address: req.body.address,
    mobile: req.body.mobile_number,
  };

  Investor.findOneAndUpdate(
    { email: req.body.email },
    { $set: updateData },
    { new: true, useFindAndModify: false }
  )
    .then((data) => {
      if (!data) {
        return res.status(404).json({
          success: false,
          message: "Resource not found",
        });
      } else {
        return res.status(200).json({
          success: true,
          message: `Investor Profile edited.`,
          data: data,
        });
      }
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};
