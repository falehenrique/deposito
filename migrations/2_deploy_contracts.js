var DepositWithdraw = artifacts.require("./DepositWithdraw.sol");

module.exports = function(deployer) {
    deployer.deploy(DepositWithdraw);
};
