pragma solidity <%=pragmaSolidity%>;

import "framework/doug_contract.sol";

contract DougEntity is DougContract {

    function DougEntity(address _MAIN) {
        MAIN = _MAIN;
    }
}
