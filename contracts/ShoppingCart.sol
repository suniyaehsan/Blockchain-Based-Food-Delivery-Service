// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract ShoppingCart {
    // it is added to kepp check if items
    enum ItemStatus {
        InProcess,
        Cancelled,
        Complete
    }
    struct Item {
        string name;
        uint price;
        uint quantity;
        ItemStatus status;
    }

    mapping(address => Item[]) public cart;

    event ItemAdded(
        address indexed user,
        string name,
        uint price,
        uint quantity
    );
    event OrderCancelled(address indexed user, uint indexed orderId);

    //   no need to send qty from fromt end just add 1 need price from user
    function addItem(string calldata _name, uint _price) external {
        bool itemFound = false;

        for (uint i = 0; i < cart[msg.sender].length; i++) {
            if (
                keccak256(bytes(cart[msg.sender][i].name)) ==
                keccak256(bytes(_name)) &&
                (cart[msg.sender][i].status == ItemStatus.InProcess)
            ) {
                cart[msg.sender][i].quantity++;
                itemFound = true;
                break;
            }
        }
        // this status tracks if user adding item and order is new
        if (!itemFound) {
            cart[msg.sender].push(Item(_name, _price, 1, ItemStatus.InProcess));
        }
        //   emit event
        emit ItemAdded(msg.sender, _name, _price, 1);
    }

    function checkout() external {
        Item[] storage items = cart[msg.sender];
        uint totalAmount = 0;

        for (uint i = 0; i < items.length; i++) {
            if (items[i].status == ItemStatus.InProcess) {
                totalAmount += items[i].price * items[i].quantity;
                items[i].status = ItemStatus.Complete; // Change status to Complete
            }
        }
    }
}
