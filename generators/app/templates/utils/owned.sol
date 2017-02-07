pragma solidity <%=pragmaSolidity%>;

contract owned {

    address owner;

    function owned () {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender == owner) _;
    }
}
