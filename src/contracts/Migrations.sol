// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address public owner = msg.sender; //i am the owner, i am the caller address (my wallet)
  uint public last_completed_migration; //keeps track of each migration 

  modifier restricted() { //modifer is a restriction that basically asserts and requires something to be expected, security measurement
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner!"
    );
    _; //means continue
  }

  function setCompleted(uint completed) public restricted { //keeps track of our completions
    last_completed_migration = completed; //set completion to the last completed migration
  }


  //allows us to keep track of our migrations
  function upgrade(address new_address) public restricted { 

    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);

  }

}
