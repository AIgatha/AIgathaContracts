pragma solidity ^0.4.21;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender account.
   */
  function Ownable() public{
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) onlyOwner public{
    if (newOwner != address(0)) {
      owner = newOwner;
    }
  }

}

/**
 * @title ERC20 interface
 * @dev Used on all ERC20 standard contract
 */
interface ERC20 { function transfer(address _to, uint256 _value) external returns (bool); }


/**
 * @title AIgathaVault
 * @author Jun-You Liu, Ping Chen
 * @dev The locker used to lock token operation in a token contract in a fixed period
 */
contract AIgathaVault is Ownable {
  address public token;
  address public wallet;

  uint256 public unlockPeriod;
  uint256 public nextUnlockTime;
  uint256 public unlockAmount;

  /**
   * @dev Constructor of AIgathaVault
   * @param _token The address where the token contract is
   * @param _wallet The address needed to be locked
   * @param _unlockPeriod The period to be locked on token
   * @param _unlockAmount The amount should be unlocked in each unlockPeriod
   */
  function AIgathaVault(address _token, address _wallet, uint256 _unlockPeriod, uint256 _unlockAmount) public {
    token = _token;
    wallet = _wallet;
    unlockPeriod = _unlockPeriod;
    unlockAmount = _unlockAmount * (10 ** 18);
    nextUnlockTime = now + unlockPeriod;
  }

  /**
   * @dev Claim the whole unlockAmount of token back to the wallet
   */
  function claim() public onlyOwner {
    require(now >= nextUnlockTime);
    ERC20 erc20 = ERC20(token);
    nextUnlockTime += unlockPeriod;
    require(erc20.transfer(wallet, unlockAmount));
  }

  /**
   * @dev Withdraw the certain amount of token back to the wallet
   * @param amount token amount
   */
  function withdraw(uint256 amount) public onlyOwner {
    require(now >= nextUnlockTime);
    require(amount < unlockAmount);
    ERC20 erc20 = ERC20(token);
    nextUnlockTime += unlockPeriod;
    require(erc20.transfer(wallet, amount));
  }

}