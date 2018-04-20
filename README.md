# AIgatha Contracts
AIgatha Ethereum contracts consist of
+ AIgathaToken contract - the coin supposed to be the main digital asset in AIgatha application; emits XXXs to investors during Presale and Publicsale phases.

+ Vault contract - We designed the Vault Contract to store XXX token and lock ... until releasing token by period.

+ Ethereum Multisignature Wallet - 
# Token contract
ATH is [ERC-20](https://github.com/ethereum/EIPs/issues/20) standard token with the following paramaters:
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
```ruby
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



# vault contract operation
![test](/images/vaultcontract_operation.png)

















