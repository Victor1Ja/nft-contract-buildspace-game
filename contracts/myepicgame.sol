// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract MyEpicGame {

  struct CharacterAttributes {
    uint characterIndex;
    string name;
    string imageURI;
    uint32 hp;
    uint32 maxHp;
    uint32 attackDamage;
  }
  CharacterAttributes[] defaultCharacters;

  constructor(
    string [] memory characterNames, 
    string [] memory characterImageURIs, 
    uint32[] memory characterHp, 
    uint32[] memory characterAttackDmg 
  ) 
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
    
    //console.log("THIS IS MY GAME CONTRACT. NICE.");
  }
}