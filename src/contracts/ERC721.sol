// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

   /*

        we want to mint a token 
        building out the minting function
            1. nft to point to an address
            2. keep track of the token ids
            3. keep track of the token owner addresses to token ids
            4. keep track of how many tokens an owner address has
            5. create an event that emits a transfer log - contract address, where it is being minted to and id

    */
contract ERC721 {

    //shows data, logs our transfer event
    event Transfer(address indexed from, address indexed to, uint indexed tokenId);

    //create a map in solidity
    //mapping in solidity creates a hash table of key pair values
    //create mapping from token id to the owner addresse
    //helps keep track of all the owners of the NFT
    mapping(uint => address) private _tokenOwner;

    //mapping from owner to number of owned tokens
    //how many tokens an address has
    //keeps track of the total tokens that a given address has
    mapping(address => uint) private _ownedTokensCount;

    // @notice Count all NFTs assigned to an owner
    // @dev NFTs assigned to the zero address are considered invalid, and this
    //  function throws for queries about the zero address.
    // @param _owner An address for whom to query the balance
    // @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns(uint256){

        require(_owner != address(0),'owner query for non-existent token');
        return _ownedTokensCount[_owner];
    }

    // @notice Find the owner of an NFT
    // @dev NFTs assigned to zero address are considered invalid, and queries
    // about them do throw.
    // @param _tokenId The identifier for an NFT
    // @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address){

        address owner = _tokenOwner[_tokenId];
        require(owner != address(0),'owner query for non-existent token');
        return owner;

    }


    function _exists(uint tokenId) internal view returns (bool){
        //setting address to nft owner to check the mapping of the address from token ownser at the tokenId 
        address owner = _tokenOwner[tokenId];
        //return the addres is not zero (truthiness)
        return owner != address(0);
    }

    function _mint(address to, uint tokenId) internal {

        //require that the address is not zero 
        require(to != address(0),'token address is invalid, ERC721 is minting to zero address');
        //requires that the token does not already exists
        require(!_exists(tokenId),'ERC721 token already minted');
        // we are adding a new address with at token id for minting 
        _tokenOwner[tokenId] = to;
        // keeping track of each address that is minting and adding one to the count
        _ownedTokensCount[to] += 1;
        //'to' is the person/bot that is minting the NFT
        emit Transfer(address(0), to, tokenId);
    
    }

}