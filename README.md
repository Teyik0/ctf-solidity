# HackMeIfYouCan.s.sol exploit explanations

## 1. Hack flip() function

Check the value of flip before using the same calcul as in the function and send the right value.

## 2. Hack addPoint() function

The exploit use tx.origin, create another contract to call the addPoint() function.

## 3. Hack transfer() function

Very simple underflow exploit

## 4. Hack goTo() function

As transfer() it rely on tx.origin so another contract need to be created.
But it needs to use the same interface as the Building interface in HackMeIfYouCan.sol
Another thing is that isLastFloor() function should not return twice the same value.

## 5. Hack sendKey() function

The exploit rely on the fact that all data are visible on chain.
Just get the data[12] value on chain and cast to bytes16 to start the function.
To get the value use bytes32(uint256(16)). 16 is the index of the data[12] value.

## 6.Hack sendPassword() function

Same exploit as before

## 7. Hack receive() callBack function

Call contribute first to get the right value for the callBack function.
Then call receive() with the right value.
