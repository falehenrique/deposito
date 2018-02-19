var DepositWithdraw = artifacts.require("./DepositWithdraw.sol");

contract('DepositWithdraw', function(accounts) {

  var  owner   = accounts[0];
  var  depositor1 = accounts[1];
  var  depositor2 = accounts[2];

  it("should assert true", function() {
    var depositWithdrawInstance;

    return DepositWithdraw.deployed().then(function(instance){
        depositWithdrawInstance = instance;
      
        depositWithdrawInstance.deposit({from:owner, value:web3.toWei(2, 'Ether')});

        depositWithdrawInstance.deposit({from:depositor1, value:web3.toWei(2, 'Ether')});

        depositWithdrawInstance.deposit({from:depositor2, value:web3.toWei(6, 'Ether')});
        
        depositWithdrawInstance.deposit({from:owner, value:web3.toWei(2, 'Ether')});

      return depositWithdrawInstance.getBalance.call();
    }).then(function(result){
      var balance = web3.fromWei(result,"Ether");
      console.log('Saldo contrato =',balance.toNumber(), " Ethers")
      depositWithdrawInstance.withdraw({from:owner});

    return depositWithdrawInstance.getBalance.call()
    }).then(function(result){
        assert.equal(web3.fromWei(result, 'Ether'), 8, "Valor após o saque da conta 0");
    });
  });
});