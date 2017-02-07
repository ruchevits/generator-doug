pragma solidity <%=pragmaSolidity%>;
<% if (isStringsLibrary){ %>
import "libraries/strings.sol";<% } %>
import "framework/doug_provider.sol";

contract DougContract {
    <% if (isStringsLibrary){ %>
    using strings for *;
    <% } %>
    address MAIN;

    // Set address of the main contract.
    function setMainAddress (address mainAddr) external returns (uint errCode) {

        if (MAIN != 0x0 && msg.sender != MAIN) return 1;
        MAIN = mainAddr;

        return 0;
    }

    function getContract (bytes32 name) internal returns (address _addr) {

        // If address of the main contract is not set.
        if (MAIN == 0x0) throw;

        address addr = DougProvider(MAIN).contracts(name);

        // If requested contract is not found.
        if (addr == 0x0) throw;

        return addr;
    }

    modifier onlyBy (bytes32 name) {
        if (MAIN == 0x0) throw;
        if (msg.sender == DougProvider(MAIN).contracts(name)) _;
    }
}
