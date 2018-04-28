# AIgatha Contracts (A draft document)
AIgatha Ethereum contracts consist of
+ AIgathaToken contract - the coin will be the main digital asset in AIgatha application; emits XXXs to investors during Presale and Publicsale phases.

+ AIgathaVault contract - the primary function of this contract is to save and lock part of the token. The token will be sent to the appointed wallet after the unlocking stage.

+ Ethereum Multisignature Wallet - we used [gnosis](https://github.com/gnosis/MultiSigWallet) to make our multisignature wallet.
# Token contract
XXX is [ERC-20](https://github.com/ethereum/EIPs/issues/20) standard token with the following paramaters:
+ Name: AIgatha token
+ Symbol: __XXX__
+ Decimals: __18__
+ Mintable: __No__
+ Burnable: __Yes__, owner can burn his tokens
+ Source Code: [AIgathaToken.sol]()
+ Mainnet address: [Not deployed yet]()
# Crowdsale schedule
In our AIgatha project, we receive ethers and send back corresponding amount of XXX tokens. Token price depends on the current stage (see the schedule). The following table shows each stage of the crowdsale. The starting date, ending date and ETH token price of each stage are all clearly displayed.
### Crowdsale schedule

|Phase|Ph.Name|Start date (UTC)|Start Unix|End date (UTC)|End Unix|Price, ETH|
|---|---|---|---|---|---|---|
|1|Presale-1|2018-05-11 00:00:00|1525968000|2018-06-10 23:59:59|1528646399|14,000|
|2|Presale-2|2018-06-11 00:00:00|1528646400|2018-06-20 23:59:59|1529510399|12,500|
|3|Presale-3|2018-06-21 00:00:00|1529510400|2018-06-30 23:59:59|1530374399|11,500|
|4|Publicsale-1|2018-07-01 00:00:00|1530374400|2018-07-15 23:59:59|1531670399|10,500|
|5|Publicsale-2|2018-07-16 00:00:00|1531670400|2018-07-31 23:59:59|1533052799|10,000|

### Crowdsale schedule modification
The crowdfunding will be only extended once if we fail to reach the threshold at the end of the first fundraising.
```javascript
function extendSaleTime() onlyOwner public {
  require(!saleActive());
  require(!extended);
  require(supply() >= threshold);
  extended = true;
  endDate += 60 days;
}
```
# Crowdsale Specification
+ AIgatha token is ERC-20 compliant.
+ AIgatha token is hardcapped at 2 billion tokens.
+ AIgatha token is non-mintable.
+ Any excess token will be locked by the owner at the end of the crowdsale.
+ AIgatha tokens will be released during the crowdsale, but the tokes will only be transferable after the crowdsale ends.
+ __Presale__ contributors are required to be whitelisted.
+ Crowdsale will be extended for another two months if we fail to reach the threshold.
+ The threshold of crowdsale: 0.4 billion AIgatha tokens.

### Token Distribution
![Token Distribution](/images/token_distribution.png)


# Smart Contracts Code
### Development Framework
> + The safeMath library and Ownable contract are referred to openZeppelin
> + tokenRecipient is the contract interface which is comply with `receiveApproval` and used by `approveAndCall`
> + TokenERC20 is the contract standard ERC20 token with burnable functions

### AIgathaToken Contract Functions
Documentation are listed as follows.
#### AIgathaToken
```javascript
function AIgathaToken(address _wallet, uint256 _saleCap, uint256 _totalSupply, uint256 _threshold, uint256 _start, uint256 _end)
```
+ @dev Constructor of AIgatha Token
+ @param _wallet The address where funds are collected
+ @param _saleCap The token cap in public round
+ @param _totalSupply The total amount of token
+ @param _threshold The percentage of selling amount need to achieve at least e.g. 40% -> _threshold = 40
+ @param _start The start date in seconds
+ @param _end The end date in seconds

#### supply
```javascript
function supply() internal view returns (uint256)
```
return the remaining sales cap at the calling moment. It can be used internally.
#### saleActive
```javascript
function saleActive() public view returns (bool)
```
to see whether it is on-sale or not.
#### extendSaleTime
```javascript
function extendSaleTime() onlyOwner public
```
extend the sales time if the sold amount is not achieve the threshold amount set in the beginning. By calling this function, it will extend the sale time 2 months more. It can only be called by owner.
#### getRateAt
```javascript
function getRateAt(uint256 at) public view returns (uint256)
```
get the exchange rate of ether to token at `at` time.
#### push
```javascript
function push(address buyer, uint256 amount) onlyOwner public
```
push `amount` to `buyer` who bought the token in preICO by owner.
#### buyTokens
```javascript
function buyTokens(address sender, uint256 value) internal
```
`sender` uses `value` ether to buy tokens with rate obtained from `getRateAt()` 
#### withdraw
```javascript
function withdraw() onlyOwner public 
```
withdraw all ether in the contract back to the wallet where save the whole funds. This function can only be called by owner.
#### finalize
```javascript
function finalize() onlyOwner public
```
owner lock manually all the remain token which is unsold after the selling period and make token capable of being tranferred.
#### functioni
```javascript
function () payable public
```
fallback function which will redirect to `buyToken()`.
### AIgathaToken Contract Events
#### Burn
```javascript
event Burn(address indexed from, uint256 value);
```
#### Transfer
```javascript
event Transfer(address indexed from, address indexed to, uint256 value);
```
#### Approval
```javascript
event Approval(address indexed owner, address indexed spender, uint256 value);
```
#### TokenPurchase
```javascript
event TokenPurchase(address indexed purchaser, uint256 value, uint256 amount);
```
#### PreICOTokenPushed
```javascript
event PreICOTokenPushed(address indexed buyer, uint256 amount);
```
#### UserIDChanged
```javascript
event UserIDChanged(address owner, bytes32 user_id);
```
### AIgathaVault Contract Functions
> It is used to lock the `unlockAmount` of token in `wallet` every `unlockPeriod`. 
> Therefore, one wallet should correspond to one contract like this Basic token locker which can only be operated by owner.

+ Documentation are listed as follows.

#### AIgathaVault
```javascript
function AIgathaVault(address _token, address _wallet, uint256 _unlockPeriod, uint256 _unlockAmount) public
```
+ @dev Constructor of AIgathaVault
+ @param _token The address where the token contract is
+ @param _wallet Sent the token to appointed address after the unlocking stage
+ @param _unlockPeriod The period to be locked on token
+ @param _unlockAmount The amount should be unlocked in each unlockPeriod
#### claim
```javascript
function claim() public onlyOwner
```
owner claim that all `unlockAmount` of token can be sent to wallet after `unlockPeriod` passed by.
#### withdraw
```javascript
function withdraw(uint256 amount) public onlyOwner
```
owner withdraw `amount` of token, which is part of `unlockAmount` , to wallet after `unlockPeriod` passed by.

# Smart Contract operation
### AIgathaToken Contract Process flow diagram
![vaultcontract_operatio](/images/aigathatoken_operation.png)
### AIgathaVault Contract Process flow diagram
![vaultcontract_operatio](/images/vaultcontract_operation.png)
### Locking period  
![unlocktime](/images/unlocktime.png)

# Authors
AIgatha team: [Site](https://aigatha.com), [GitHub](https://github.com/AIgatha)
