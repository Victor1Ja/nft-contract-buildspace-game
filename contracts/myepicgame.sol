// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./libraries/Base64.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";



contract MyEpicGame is ERC721{

  struct CharacterAttributes {
    uint characterIndex;
    string name;
    string imageURI;
    uint32 hp;
    uint32 maxHp;
    uint32 attackDamage;
  }
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  CharacterAttributes[] defaultCharacters;

  mapping(uint256 => CharacterAttributes) public nftHolderAttributes;

  mapping(address => uint256) public nftHolders;

  constructor(
    string [] memory characterNames, 
    string [] memory characterImageURIs, 
    uint32[] memory characterHp, 
    uint32[] memory characterAttackDmg 
  )  ERC721("Super Weird Whales", "SWW")
  {
    for(uint i = 0 ; i < characterNames.length ; i +=1){
      defaultCharacters.push(CharacterAttributes({
        characterIndex: i,
        name: characterNames[i],
        imageURI: characterImageURIs[i],
        hp: characterHp[i],
        maxHp: characterHp[i],
        attackDamage: characterAttackDmg[i]
      }));
     CharacterAttributes memory c = defaultCharacters[i];
     console.log("Done init %s w/ HP %s, img %s", c.name, c.hp, c.imageURI);
     
    }
    _tokenIds.increment();
    console.log("tokens amount: %d", _tokenIds.current());
    
    //console.log("THIS IS MY GAME CONTRACT. NICE.");
  }

  function mintCharacterNFT(uint _characterIndex) external{
    uint256 newItemId= _tokenIds.current();

    _safeMint(msg.sender, newItemId);

    nftHolderAttributes[newItemId] = CharacterAttributes({
      characterIndex: _characterIndex,
      name: defaultCharacters[_characterIndex].name,
      imageURI: defaultCharacters[_characterIndex].imageURI,
      hp: defaultCharacters[_characterIndex].hp,
      maxHp: defaultCharacters[_characterIndex].maxHp,
      attackDamage: defaultCharacters[_characterIndex].attackDamage
    });

    console.log("Minted NFT w/ tokenId %s and characterIndex %s", newItemId, _characterIndex);

    nftHolders[msg.sender] = newItemId;
    _tokenIds.increment();

  }
  //set token UTI
  function tokenURI(uint256 _tokenId) public view override returns( string memory){
    CharacterAttributes memory charAttributes = nftHolderAttributes[_tokenId];

    string memory strHp = Strings.toString(charAttributes.hp);
    string memory strMaxHp = Strings.toString(charAttributes.maxHp);
    string memory strAttackDamage = Strings.toString(charAttributes.attackDamage);

    string memory json = Base64.encode(
      abi.encodePacked(
        '{"name" :"',
        charAttributes.name, ' -- NFT #:',
        Strings.toString(_tokenId),
        '", "description": "This is a COPY of a Weird Whale that lets peaple play in the game Metaverse Slayer", "image": "',
        charAttributes.imageURI,
        '", "attributes": [ { "trait_type": "Health Points", "value": ',strHp,', "max_value":',strMaxHp,'}, { "trait_type": "Attack Damage", "value": ',
        strAttackDamage, '} ]}'
      )
    );
    string memory output = string(
      abi.encodePacked("data:application/json;base64,", json)
      );

    return output;

  }

}