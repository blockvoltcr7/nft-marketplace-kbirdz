// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {

    // array to store our nfts
    string[] public KryptoBirdz;

    //mapping to check if an id already exists
    //allows us to keep track of the nfts we mint
    mapping(string => bool) _KryptoBirdzExists; //every time we mint we will add true to each nft we mint 

 
    function mint(string memory _kryptoBird) public {
       
       require(!_KryptoBirdzExists[_kryptoBird], 'Error - krypto bird already exists');
        KryptoBirdz.push(_kryptoBird);
        uint _id = KryptoBirdz.length - 1; 
        _mint(msg.sender, _id);
        _KryptoBirdzExists[_kryptoBird] = true;

    }

    //initialize the contract with name and symbol 
    constructor() ERC721Connector('KryptoBids','KBIRDZ') public {}
     


}