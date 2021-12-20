//SPDX-License-Identifier: MIT
pragma solidity >=0.6.6 < 0.9.0;


import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe{
    using SafeMathChainlink for uint256; 

    //msg.sender adress the accoutn that send
    //msg.value amount of money send
    mapping (address => uint256) public AddressToAmount;
    address[] public funders;
    address public owner;
    constructor() public{
      owner = msg.sender;

    }
    function fund() public payable {
        uint256 minimumUSD = 2* 10**18; 

        // require to complete the transaction, msg error
        require(getCoversionRate(msg.value) >= minimumUSD, "Transaction not complete");
        AddressToAmount[msg.sender] += msg.value;
        funders.push(msg.sender);
        // eth -usdt coversion rate
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface  priceFee = AggregatorV3Interface(address(0x9326BFA02ADD2366b30bacB125260Af641031331));
        return priceFee.version();
    
    }
    function getPrice() public view returns(uint256){
      AggregatorV3Interface priceFee = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
      // lastest return 5 variables, but i only want the answer variable
      (,int256 answer,,,)= priceFee.latestRoundData();
      //get eth to usdt price
      return uint256(answer*10e10);

    }
    // doesn not return the value with decimals, so i need use a fuction to transofrm the number 

    function getCoversionRate(uint256 ethamount) public view returns(uint256){
      uint256 ethPrice = getPrice();
      uint256 ethamountInUSDT = (ethPrice * ethamount)/10e18;
      return ethamountInUSDT;
      }
    //used to changethe
    //behavior of a fuction in a declarative way
    modifier onlyOwner {
      require(msg.sender == owner);
      //run the rest of the code
      _;
    }

    function withdraw() payable onlyOwner public{
      //getting all money in this contract
      msg.sender.transfer(address(this).balance);

      for (uint256 funderIndex=0; funderIndex<funders.length; funderIndex++){

        address funder = funders[funderIndex];
        AddressToAmount[funder] = 0;
        

      }
      //depois de vazio nao volta a setar 0
       funders = new address[](0);
 
    }

}

