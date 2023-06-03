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
}