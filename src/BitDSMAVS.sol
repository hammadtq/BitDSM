pragma solidity ^0.8.12;

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@eigenlayer/contracts/libraries/BytesLib.sol";
import "@eigenlayer-middleware/src/ServiceManagerBase.sol";
import "./BodManager.sol";
import "./CDPContract.sol";

contract BitDSMAVS is ServiceManagerBase {
    BodManager public immutable bodManager;
    CDPContract public immutable cdpContract;

    uint32 public latestTaskNum;
    mapping(uint32 => bytes32) public allTaskHashes;
    mapping(uint32 => LockBitcoinTask) public lockBitcoinTasks;

    struct LockBitcoinTask {
        address bodOwner;
        bytes32 btcTxHash;
        uint256 amount;
        bool executed;
    }

    event NewLockBitcoinTaskCreated(uint32 taskId, address bodOwner, bytes32 btcTxHash, uint256 amount);
    event LockBitcoinTaskExecuted(uint32 taskId);

    constructor(
        IAVSDirectory _avsDirectory,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        address _bodManager,
        address _cdpContract
    )
        ServiceManagerBase(
            _avsDirectory,
            IPaymentCoordinator(address(0)), // Assuming no payment handler is needed
            _registryCoordinator,
            _stakeRegistry
        )
    {
        bodManager = BodManager(_bodManager);
        cdpContract = CDPContract(_cdpContract);
    }

    function initialize(
        IAVSDirectory _avsDirectory,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        address _bodManager,
        address _cdpContract
    ) external {
        // Initialize the contract with the provided parameters
        // This function can be used to set up any additional state or perform any necessary actions
    }

    function createLockBitcoinTask(bytes32 btcTxHash, uint256 amount) external {
        require(bodManager.hasBod(msg.sender), "Sender does not have a BOD");
        
        LockBitcoinTask memory newTask = LockBitcoinTask({
            bodOwner: msg.sender,
            btcTxHash: btcTxHash,
            amount: amount,
            executed: false
        });

        uint32 taskId = latestTaskNum++;
        lockBitcoinTasks[taskId] = newTask;
        allTaskHashes[taskId] = keccak256(abi.encode(newTask));

        emit NewLockBitcoinTaskCreated(taskId, msg.sender, btcTxHash, amount);
    }

    function executeLockBitcoinTask(uint32 taskId) external onlyOwner {
        LockBitcoinTask storage task = lockBitcoinTasks[taskId];
        require(!task.executed, "Task already executed");
        require(keccak256(abi.encode(task)) == allTaskHashes[taskId], "Task data mismatch");

        bodManager.lockBitcoin(task.btcTxHash, task.amount);
        task.executed = true;

        emit LockBitcoinTaskExecuted(taskId);
    }
}
