pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

abstract contract BlackList is Ownable2Step{
    error InvalidAddress(address target);

    event Blacklisted(address indexed target);
    event UnBlacklisted(address indexed target);
    mapping (address => bool) public blackList;
    
    modifier isNotBlackListed(address _maker) {
        if(blackList[_maker]){
            revert InvalidAddress(_maker);
        }
        _;
    }

    function getBlackListStatus(address _maker) external view returns (bool) {
        return blackList[_maker];
    }

    function addBlackList (address _evilUser) external onlyOwner {
        blackList[_evilUser] = true;
        emit Blacklisted(_evilUser);
    }

    function removeBlackList (address _clearedUser) external onlyOwner {
        blackList[_clearedUser] = false;
        emit UnBlacklisted(_clearedUser);
    }

}

contract TB_coin is ERC20, Pausable, BlackList{

    error InvaildAmount(address target, uint256 amount);
    event Mint(address indexed dst, uint256 amount);
    event Burn(address indexed src, uint256 amount);
    
    constructor(string memory name, string memory symbl)Ownable()ERC20(name,symbl){

    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    // when user deposit, mint the same amount of ERC20 token
    function mint(address to, uint amount) public whenNotPaused onlyOwner isNotBlackListed(to) {
        if(!(amount > 0)) {
            revert InvaildAmount(to, amount);
        }

        _mint(to, amount);
        emit Mint(to, amount);
    }

    // when user withdraw, burn the same amount of ERC20 token
    function burn(address to, uint amount) public whenNotPaused onlyOwner isNotBlackListed(to) {
        if(!(balanceOf(to) >= amount)) {
            revert InvaildAmount(to, amount);
        }

        _burn(to, amount);
        emit Burn(to, amount);
    }

    function transfer(address to, uint256 value) public override whenNotPaused isNotBlackListed(msg.sender) returns (bool) {
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public override whenNotPaused isNotBlackListed(from) returns (bool) {
        return super.transferFrom(from, to, value);
    }
}