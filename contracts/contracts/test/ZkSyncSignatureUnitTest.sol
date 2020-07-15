pragma solidity ^0.5.0;

import "../generated/ZkSyncTest.sol";


contract ZKSyncSignatureUnitTest is ZkSyncTest {

    function changePubkeySignatureCheck(bytes calldata _signature, bytes20 _newPkHash, uint32 _nonce, address _ethAddress, uint24 _accountId) external returns (bool) {
        (bool blockProcessorCallSuccess, bytes memory encodedResult) = blockProcessorAddress.delegatecall(
            abi.encodeWithSignature(
                "verifyChangePubkeySignature(bytes,bytes20,uint32,address,uint32)",
                    _signature,
                    _newPkHash,
                    _nonce,
                    _ethAddress,
                    uint32(_accountId)
            )
        );
        require(blockProcessorCallSuccess, "vcpks91"); // vcpks91 - `verifyChangePubkeySignature` delegatecall fails
        return abi.decode(encodedResult, (bool));
    }

    function testRecoverAddressFromEthSignature(bytes calldata _signature, bytes calldata _message) external pure returns (address) {
        return Utils.recoverAddressFromEthSignature(_signature, _message);
    }

}
