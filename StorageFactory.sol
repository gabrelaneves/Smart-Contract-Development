// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

//inheritance
contract StorageFactory  is SimpleStorage {
    
    SimpleStorage[] public simpleStorageArray;
    
    // deploy one contract from another contract and keeping track of it by
    //using an Array structure
    function createSimpleStorageContract() public {
        SimpleStorage simple = new SimpleStorage();
        simpleStorageArray.push(simple);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //to interact with a contract, I need the:
        //Adress  - get from the array
        //and ABI - get from the import
        SimpleStorage simpcontract = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpcontract.store(_simpleStorageNumber);

    }

    function sfRetrive(uint256 _simpleStorageIndex) public view returns (uint256){
        SimpleStorage simpcontract = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpcontract.retriever(); 
    }
}