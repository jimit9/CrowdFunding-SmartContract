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
    struct Request {
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping (address=>bool) voters;
    }
    mapping (uint=>Request) public requests;
    uint public noOfRequests;
    constructor(uint _minContribution,uint _deadline,uint _target){
        minContribution=_minContribution;
        deadline=block.timestamp + _deadline;
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
    function createRequest(string memory _description,address payable _recipient, uint _value) public {
        require(msg.sender==manager,"only manager can call this function!");
        Request storage newRequest = requests[noOfRequests];
       newRequest.description=_description;
       newRequest.recipient=_recipient;
       newRequest.value=_value;
       newRequest.completed=false;
       newRequest.noOfVoters=0;
       noOfRequests++;
    }
    function voteRequest(uint _requestNo) public {
        require(contributors[msg.sender]>0,"you're not a contributor.");
        Request storage thisRequest = requests[_requestNo];
        if(thisRequest.voters[msg.sender]==false){
            thisRequest.voters[msg.sender]==true;
            thisRequest.noOfVoters++;
        }
        
            revert("you've already voted");

    }

}