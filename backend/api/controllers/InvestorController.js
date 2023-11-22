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
exports.getRequestedCultivation = (req, res) => {
  CulProposal.aggregate([
    {
      $lookup: {
        from: "farmer_details",
        localField: "farmer_email",
        foreignField: "email",
        as: "farmerDetails",
      },
    },
    { $unwind: "$farmerDetails" },
    {
      $match: {
        investor_email: req.body.investor_email,
        proposal_status: "approved",
        cultivation_status: "requested",
        proposal_response: "sent"
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
        message: `Requested Proposal found`,
        requestedProposalDetails: proposals,
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

exports.requestCultivation = (req, res) => {
  const updateData = {
    cultivation_status: "requested",
    investor_email: req.body.investor_email,
    proposal_response: "sent",
  };

  CulProposal.findOneAndUpdate(
    { _id: req.body.proposal_id },
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
          message: `Proposal requested`,
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

exports.deleteRequestedCultivation = (req, res) => {
  const updateData = {
    investor_email: "",
    cultivation_status: "pending",
    proposal_response: "",
  };

  CulProposal.findOneAndUpdate(
    { _id: req.body.proposal_id, investor_email : req.body.investor_email },
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
          message: `Requested Cultivation Deleted successfully.`,
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
