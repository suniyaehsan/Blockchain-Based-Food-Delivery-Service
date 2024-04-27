// pragma solidity ^0.5.0;

// contract ShoppingCart {
//     // Define a struct to represent an item
//     struct Item {
//         uint itemId;
//         string itemName;
//         uint price;
//         uint quantity;
//     }
//     uint public total_price;
//     // Define a mapping to store items by their ID
//     mapping(uint => Item) public items;

//     // Define a function to add items to the cart
//     function addItem(
//         uint _itemId,
//         string memory _itemName,
//         uint _quantity,
//         uint _price
//     ) public {
//         // Check if the item already exists
//         if (items[_itemId].itemId != 0) {
//             items[_itemId].quantity += _quantity;
//         } else {
//             items[_itemId] = Item(_itemId, _itemName, _quantity, _price);
//         }
//     }

//     // Define a function to calculate the total price of all items in the cart
//     function calculateTotal() public view returns (uint) {
//         total_price = 0;
//         for (uint i = 1; i <= items.lenght; i++) {
//             total_price += items[i].price * items[i].quantity;
//         }
//     }
// }

pragma solidity ^0.5.0;

contract ShoppingCart {
    // Define a struct to represent an item
    struct Item {
        uint itemId;
        string itemName;
        uint price;
        uint quantity;
    }

    // Define a mapping to store items by their ID
    mapping(uint => Item) public items;

    // Array to keep track of item IDs
    uint[] public itemIds;

    // Variable to store the total price
    uint public total;

    // Define a function to add items to the cart
    function addItem(
        uint _itemId,
        string memory _itemName,
        uint _price,
        uint _quantity
    ) public {
        // Check if the item already exists
        if (items[_itemId].itemId != 0) {
            items[_itemId].quantity += _quantity;
        } else {
            items[_itemId] = Item(_itemId, _itemName, _price, _quantity);
            itemIds.push(_itemId); // Add item ID to the array
        }
    }

    // Function to get the number of items in the cart
    function getItemCount() public view returns (uint) {
        return itemIds.length;
    }

    // Function to get item details by index
    function getItemByIndex(
        uint index
    ) public view returns (uint, string memory, uint, uint) {
        uint itemId = itemIds[index];
        return (
            items[itemId].itemId,
            items[itemId].itemName,
            items[itemId].price,
            items[itemId].quantity
        );
    }

    // Define a function to calculate the total price of all items in the cart
    function calculateTotal() public {
        total = 0;
        for (uint i = 0; i < itemIds.length; i++) {
            uint itemId = itemIds[i];
            total += items[itemId].price * items[itemId].quantity;
        }
    }
}
