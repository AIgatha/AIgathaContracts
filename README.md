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
+ Mintable: __Yes__, Special role for minting, Tapped (limited speed), Finalizeable
+ Burnable: __Yes__, owner can burn his tokens
+ RBAC: __Yes__, Minters (mint), Owners (add minters)
+ Source Code: [AIgathaToken.sol]()
+ Mainnet address: [Not deployed yet]()
# Crowdsale schedule
Crowdsale rule for AIgatha project. It receives ethers and sends back corresponding amount of XXX tokens. Token price depends on the current phase (see the schedule). The following table contains a list of phases, each phase has a start time, end time and token price in ETH.

|Phase|Ph.Name|Start date (UTC)|Start Unix|End date (UTC)|End Unix|Price, ETH|
|---|---|---|---|---|---|---|
|1|Presale-1|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|14,000|
|2|Presale-2|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|12,500|
|3|Presale-3|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|11,500|
|4|Publicsale-1|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|10,500|
|5|Publicsale-2|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|10,000|

## Crowdsale schedule modification ##

The internal phases schedule can be manipulated at any time by the owner with following methods:
```
function extendSaleTime() onlyOwner public {
  require(!saleActive());
  require(!extended);
  require(supply() >= threshold);
  extended = true;
  endDate += 60 days;
}
```
# Crowdsale Specification

![test](/images/vaultcontract_operation.png)

















