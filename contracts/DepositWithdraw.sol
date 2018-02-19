pragma solidity 0.4.18;

contract DepositWithdraw {
    address private owner;
    event LogDebug(uint256 amount);
    event LogDepositReceived(address sender, uint256 value);
    Depositor[] public depositors;
    
    function DepositWithdraw() public {
       owner = msg.sender; 
    }
    
    struct Depositor {
        address depositor;
        uint256 totalAmount;
    }
    
    function deposit() payable public {
        require(msg.sender > 0 && msg.value > 0);
        depositors.push(Depositor(msg.sender,msg.value));
        LogDepositReceived(msg.sender, msg.value);
    }
    
    function() external payable {
        deposit();
    }    
    function  getBalance() public view returns (uint) {
        return this.balance;
    }    
    
    function withdraw() public {
        uint256 totalAmount = 0;
        for (uint256 i = 0; i < depositors.length; i++) {
            if (msg.sender == depositors[i].depositor) {
                totalAmount += depositors[i].totalAmount;
                delete depositors[i];
            }
        }
        LogDebug(totalAmount);
        assert(totalAmount > 0);
        msg.sender.transfer(totalAmount);
    }
    
    function killContract() public {
        require(msg.sender == owner);
        selfdestruct(owner);
    }
}