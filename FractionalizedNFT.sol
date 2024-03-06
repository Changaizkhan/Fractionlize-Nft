// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.4;

// import "@openzeppelin/contracts@4.6.0/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts@4.6.0/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
// import "@openzeppelin/contracts@4.6.0/token/ERC20/extensions/draft-ERC20Permit.sol";
// import "@openzeppelin/contracts@4.6.0/token/ERC721/utils/ERC721Holder.sol";

// contract FractionalizedNFT is ERC20, Ownable, ERC20Permit, ERC721Holder {
//     IERC721 public collection;
//     uint256 public tokenId;
//     bool public initialized = false;
//     bool public forSale = false;
//     uint256 public salePrice;
//     bool public canRedeem = false;

//     constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {}

//     function initialize(address _collection, uint256 _tokenId, uint256 _amount) external onlyOwner {
//         require(!initialized, "Already initialized");
//         require(_amount > 0, "Amount needs to be more than 0");
//         collection = IERC721(_collection);
//         collection.safeTransferFrom(msg.sender, address(this), _tokenId);
//         tokenId = _tokenId;
//         initialized = true;
//         _mint(address(this), _amount);
//     }

//     function putForSale(uint256 price) external onlyOwner {
//         salePrice = price;
//         forSale = true;
//     }

//     function purchaseNFT() external payable {
//         require(forSale, "Not for sale");
//         require(msg.value >= salePrice, "Not enough ether sent");
//         collection.transferFrom(address(this), msg.sender, tokenId);
//         forSale = false;
//         canRedeem = true;
//     }

//     function tokenPrice(uint _amount) public view returns(uint256){
//         return salePrice/totalSupply() * _amount;
//     } 

//     function purchaseToken(uint _amount) external payable {
//         require(forSale == true, "NFT is not for sale");
//         require(msg.value == tokenPrice(_amount), "Invalid NFT price");
//         IERC20(address(this)).transfer(msg.sender, _amount);
//     }

//     function redeem(uint256 _amount) external {
//         require(canRedeem, "Redemption not available");
//         require(balanceOf(msg.sender) == _amount, "Invalid redeem amount");
//         require(address(this).balance >= tokenPrice(_amount), "Not enough Funds Available");
//         uint256 toRedeem = tokenPrice(_amount);

//         // uint256 totalEther = address(this).balance;
//         // uint256 toRedeem = _amount * totalEther / totalSupply();

//         transfer(address(this), _amount);
//         (bool sent,) =  payable(msg.sender).call{value: toRedeem}("");
//         require(sent, "Failed to send Ether");
//     }
// }