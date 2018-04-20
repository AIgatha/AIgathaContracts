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
 
|Phase|Ph.Name|Start date (UTC)|Start Unix|End date (UTC)|End Unix|Price, ETH|
|---|---|---|---|---|---|---|
|1|Presale-1|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|14,000|
|2|Presale-2|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|12,500|
|3|Presale-3|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|11,500|
|4|Publicsale-1|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|10,500|
|5|Publicsale-2|2018-0X-0X 00:00:00|0000000000|2018-0X-XX 23:59:59|0000000000|10,000|



![a][./images/vaultcontract_operation.png]

















