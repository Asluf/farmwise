const { Investor } = require("../models/InvestorModel");
const { User } = require("../models/UserModel");
const { CulProposal } = require("../models/CulProposalModel");

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
      return res.status(200).json({
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
    .then((user) => {
      return res.status(200).json({
        success: true,
        message: `Investor Profile edited.`,
        data: user,
      });
    })
    .catch((err) => {
      return res.status(200).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};

exports.getApprovedCultivation = (req, res) => {
  CulProposal.aggregate([
    {
      $lookup: {
        from: "farmer_details",
        localField: "farmer_email",
        foreignField: "email",
        as: "farmerDetails",
      },
      //matching the farmer_email field in the CulProposal collection with the email field in the "farmer_details" collection.
    },
    { $unwind: "$farmerDetails" },
    {
      $match: {
        proposal_status: "approved",
        cultivation_status: "pending",
      },
    },
  ])
    .then((proposals) => {
      if (!proposals) {
        return res
          .status(404)
          .json({ success: false, message: "Proposals not found!" });
      }
      return res.status(200).json({
        success: true,
        message: `Approved Proposal found`,
        approvedProposalDetails: proposals,
      });
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};
