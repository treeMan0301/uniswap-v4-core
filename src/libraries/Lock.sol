// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.20;

import {IHooks} from "../interfaces/IHooks.sol";

/// @notice This is a temporary library that allows us to use transient storage (tstore/tload)
/// TODO: This library can be deleted when we have the transient keyword support in solidity.
library Lock {
    // The slot holding the unlocked state, transiently
    uint256 constant IS_UNLOCKED_SLOT = uint256(keccak256("Unlocked")) - 1;

    function unlock() internal {
        uint256 slot = IS_UNLOCKED_SLOT;
        assembly {
            // unlock
            tstore(slot, true)
        }
    }

    function lock() internal {
        uint256 slot = IS_UNLOCKED_SLOT;
        assembly {
            tstore(slot, false)
        }
    }

    function isUnlocked() internal view returns (bool unlocked) {
        uint256 slot = IS_UNLOCKED_SLOT;
        assembly {
            unlocked := tload(slot)
        }
    }
}
