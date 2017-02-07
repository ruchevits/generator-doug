pragma solidity <%=pragmaSolidity%>;

import "utils/owned.sol";
import "framework/doug_contract.sol";

contract DougMain is owned {

    mapping (bytes32 => address) public contracts;

    // Attach a new contract to the main contract.
    // This will overwrite an existing contract.
    function addContract(bytes32 name, address addr) onlyOwner returns (uint errCode) {

        DougContract childContract = DougContract(addr);

        // Set address of the main contract in child contract.
        uint setMainAddressErrCode = childContract.setMainAddress(address(this));
        if (setMainAddressErrCode != 0) return setMainAddressErrCode;

        // Set address of the child contract in main contract.
        contracts[name] = addr;

        return 0;
    }

    // Detach a contract from the main contract.
    function removeContract(bytes32 name) onlyOwner returns (uint errCode) {

        // If contract with a given name does not exist.
        if (contracts[name] == 0x0) return 1;

        // Detach contract with a given name.
        contracts[name] = 0x0;

        return 0;
    }
}
