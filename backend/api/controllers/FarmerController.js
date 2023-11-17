const { Farmer } = require("../models/FarmerModel");
const { User } = require("../models/UserModel");
const { CulProposal } = require("../models/CulProposalModel");

exports.getFarmer = (req, res) => {
  Farmer.findOne({ email: req.body.email })
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
                message: `Farmer found`,
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

exports.editFarmer = (req, res) => {

  const updateData = {
    farmer_name: req.body.farmer_name,
    farmer_address: req.body.farmer_address,
    farm_name: req.body.farm_name,
    mobile_number: req.body.mobile_number
  };

  Farmer.findOneAndUpdate(
    { email: req.body.email },
    { $set: updateData },
    { new: true, useFindAndModify: false }
  )
    .then((user) => {
      return res.status(200).json({
        success: true,
        message: `Farmer Profile edited.`,
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

// for concetanate the object for upload the proposa
function mergeRequestBody(reqBody, additionalProps) {
  return { ...reqBody, ...additionalProps };
}
exports.createCultivationProposal = (req, res) => {
  const file = req.file;
  if (!file) {
    return res.status(400).json({ error: "No file uploaded." });
  }
  const total_amount = parseFloat(req.body.total_amount);
  const of_farmer = parseFloat(req.body.investment_of_farmer);
  const of_investor = total_amount - of_farmer;
  var roi_farmer = 0;
  var roi_investor = 0;

  if(of_farmer< (total_amount/2)){
    roi_farmer = (of_farmer/total_amount*100)+15;
    roi_investor = 100-roi_farmer;
  }else{
    roi_farmer = of_farmer/total_amount*100;
    roi_investor = of_investor/total_amount*100;
  }


  const tempObj = {
    land_img_path : file.path,
    investment_of_investor: of_investor.toString(),
    roi_farmer: roi_farmer.toString(),
    roi_investor: roi_investor.toString()
  };
  const resultObj = mergeRequestBody(req.body, tempObj);
  const prop = new CulProposal(resultObj); 

  prop
    .save()
    .then(() => {
      return res.status(200).json({
        success: true,
        message: "Successfully posted the proposal!",
      });
    })
    .catch((err) => {
      return res.status(422).json({
        success: false,
        message: "Something went wrong!",
        data: err,
      });
    });

  

};
