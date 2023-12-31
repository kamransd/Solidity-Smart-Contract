

pragma solidity ^0.8.6;

contract Bank {
    mapping(address => uint) balance;
    address owner;
// modifier function:  modifier() is a function of solidity. Explain: If you have the power to transfer the token, then you can use the modifier function. 

    modifier onlyowner {
        require(owner == msg.sender, "you are not the owner");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function addBalance(uint _toAdd) public returns(uint) {
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];

    }

    function geBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public onlyowner {
        
        require(balance[msg.sender]>= amount, "You dont have enough balance to send.");
        require(msg.sender != recipient, "You are sender and receiver both so its not possible. ");

        uint previouSenderBalance = balance[msg.sender];

        balance[msg.sender] -= amount; 
        balance[recipient]  += amount;
        // assert function: assert() is a function that will check Internal Error.  Explain: You have 1000 tokens, you can transfer 100 tokens to another user, remaining you have 900 tokens. If you have remaining balance more than 900, less than 900 tokens then you will get error 
        assert(balance[msg.sender] ==previouSenderBalance - amount);

    }
} 
