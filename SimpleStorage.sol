// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleStorage{
    //declaring variable
    uint256 public favoriteNumber = 5;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;}
    
    
    //similar to create a class on Java
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    
    // creating a People object

    People public person = People({favoriteNumber: 3, name : "Gabi"});

    // creating people array

    People[] public people;
    mapping(string => uint256) public NameToNumber;

    // ading elements to the array
    function AddPerson(string memory _name, uint256 _favoriteNumber) public{
        people.push(People( _favoriteNumber,_name));
        NameToNumber[_name] = _favoriteNumber;
    }


    function retriever() public view returns(uint256){
        return favoriteNumber;
        

    }

    
}