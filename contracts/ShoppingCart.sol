pragma solidity ^0.5.0;

contract ShoppingCart {
    // Define a struct to represent an item
    struct Item {
        uint itemId;
        string itemName;
        uint quantity;
    }

    // Define a mapping to store items by their ID
    mapping(uint => Item) public items;

    // Define a function to add items to the cart
    function addItem(
        uint _itemId,
        string memory _itemName,
        uint _quantity
    ) public {
        // Check if the item already exists
        if (items[_itemId].itemId != 0) {
            items[_itemId].quantity += _quantity;
        } else {
            items[_itemId] = Item(_itemId, _itemName, _quantity);
        }
    }

    // Define a function to get the quantity of an item in the cart
    function getItemQuantity(uint _itemId) public view returns (uint) {
        return items[_itemId].quantity;
    }
}
