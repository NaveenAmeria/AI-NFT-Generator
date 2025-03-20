pragma solidity ^0.8.0;

contract AINFT {
    string public name = "AI Generated NFT";
    string public symbol = "AINFT";
    uint256 public totalSupply;
    mapping(uint256 => address) public ownerOf;
    mapping(uint256 => string) private _tokenURIs;
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function mint() public {
        uint256 tokenId = totalSupply + 1;
        ownerOf[tokenId] = msg.sender;
        balanceOf[msg.sender] += 1;
        _tokenURIs[tokenId] = generateMetadata(tokenId);
        totalSupply += 1;

        emit Transfer(address(0), msg.sender, tokenId);
    }

    function generateMetadata(uint256 tokenId) internal pure returns (string memory) {
        return string(abi.encodePacked("https://ai-nft.example/api/metadata/", toString(tokenId)));
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        return _tokenURIs[tokenId];
    }

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
