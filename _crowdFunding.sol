// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;
contract crowdFunding{
    mapping(address=>uint) public contributors;
    address public manager;
    uint public minContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public numOfContributors;
    constructor(uint _minContribution,uint _deadline,uint _target){
        minContribution=_minContribution;
        deadline=block.timestamp+_deadline;
        target=_target;
        manager=msg.sender;
        
    }
    function sendEth() public payable {
        require(deadline>block.timestamp,"Deadline has passed.");
        require(msg.value>=minContribution,"Send 100 wei");
        if(contributors[msg.sender]==0){
            numOfContributors++;
        }
        contributors[msg.sender]=contributors[msg.sender] + msg.value;
        raisedAmount = raisedAmount + msg.value;

    }
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function refund () public  {
        require(raisedAmount<target,"Target is already met");
        require(deadline<block.timestamp,"deadline is not passed yet"); 
        require(contributors[msg.sender]>0,"You're not a contributor");
        address payable user = payable (msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;


    }
}