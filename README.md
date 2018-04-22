# AIgatha Contracts (A draft document)
AIgatha Ethereum contracts consist of
+ AIgathaToken contract - the coin supposed to be the main digital asset in AIgatha application; emits XXXs to investors during Presale and Publicsale phases.

+ AIgathaVault contract - We designed the Vault Contract to store XXX token and lock ... until releasing token by period.

+ Ethereum Multisignature Wallet - 
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
Crowdsale rule for AIgatha project. It receives ethers and sends back corresponding amount of XXX tokens. Token price depends on the current phase (see the schedule). The following table contains a list of phases, each phase has a start time, end time and token price in ETH.
### Crowdsale schedule

|Phase|Ph.Name|Start date (UTC)|Start Unix|End date (UTC)|End Unix|Price, ETH|
|---|---|---|---|---|---|---|
|1|Presale-1|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|14,000|
|2|Presale-2|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|12,500|
|3|Presale-3|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|11,500|
|4|Publicsale-1|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|10,500|
|5|Publicsale-2|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|10,000|

### Crowdsale schedule modification

After the end of crowdfunding, if the threshold is not reached, the crowdfunding period will only be extended once.
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
+ AIgatha tokens will be released at period of the crowdsale but be transferable only after the crowdsale ends.
+ __Presale__ contributors are required to be whitelisted.
+ Extending the crowdsale for two months if the threshold is not reached.
+ Token sales threshold is 0.4 billion AIgatha tokens.

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
+ Burn
```javascript
event Burn(address indexed from, uint256 value);
```
+ Transfer
```rubjavascripty
event Transfer(address indexed from, address indexed to, uint256 value);
```
+ Approval
```javascript
event Approval(address indexed owner, address indexed spender, uint256 value);
```
+ TokenPurchase
```javascript
event TokenPurchase(address indexed purchaser, uint256 value, uint256 amount);
```
+ PreICOTokenPushed
```javascript
event PreICOTokenPushed(address indexed buyer, uint256 amount);
```
+ UserIDChanged
```javascript
event UserIDChanged(address owner, bytes32 user_id);
```
### AIgathaVault Contract Functions
> It is used to lock the `unlockAmount` of token in `wallet` every `unlockPeriod`. 
> Therefore, one wallet should correspond to one contract like this Basic token locker which can only be operated by owner.

+ Documentation are listed as follows.
+ `claim()` : owner claim that all `unlockAmount` of token can be sent to wallet after `unlockPeriod` passed by.
+ `withdraw(amount)` : owner withdraw `amount` of token, which is part of `unlockAmount` , to wallet after `unlockPeriod` passed by.


# Smart Contract operation
### AIgathaToken Contract Process flow diagram
![vaultcontract_operatio](/images/aigathatoken_operation.png)
### AIgathaVault Contract Process flow diagram
![vaultcontract_operatio](/images/vaultcontract_operation.png)
### Locking period  
![unlocktime](/images/unlocktime.png)

# Authors
AIgatha team: Site, GitHub















