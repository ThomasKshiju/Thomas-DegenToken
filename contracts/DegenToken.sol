import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    string public redeemShop;
    uint256[] public itemCosts;

    constructor() ERC20("Degen", "DGN") {
        redeemShop = "There are 5 items in your shop which you are able to redeem: 1. Ball, 2. Cap, 3. Suit, 4. Table, 5. Cloth";
        itemCosts = [0, 5, 10, 15, 20]; 
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function redeem(uint256 itemNo) public {
        require(itemNo > 0 && itemNo <= itemCosts.length, "Invalid item selection");
        require(balanceOf(msg.sender) >= itemCosts[itemNo], "Insufficient balance");

        _burn(msg.sender, itemCosts[itemNo]);
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    function burnAmount(uint256 amount)public {
        _burn(msg.sender, amount);
    }
}
