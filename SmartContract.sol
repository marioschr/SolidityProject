pragma solidity >=0.7.0 <0.9.0;

import "contracts/DateTime.sol";

contract SimpleSmartContract {
    struct Reservation {
        uint id;
        string name;
        uint numOfGuests;
        uint256 dateTime;
    }
    
    Reservation[] public reservations;
    
    // in case the program read a user that doesn't exist the id value will get the default ( witch is 0 ), where it will match with a user with id 0 if that is what we are looking
    // but the actual user with that id doesn's exist
    uint public nextId = 1;
    
    function create(string memory name, uint numOfGuests, uint8 _day, uint8 _month, uint16 _year, uint8 _hour, uint8 _minutes) public {
        reservations.push(Reservation(nextId, name, numOfGuests, DateTime.toTimestamp(_year,_month,_day,_hour,_minutes)));
        nextId++;
    }
    
    function read(uint id) view public returns(uint , string memory, uint, DateTime._DateTime memory) {
        uint i = find(id);
        return (
            reservations[i].id,
            reservations[i].name,
            reservations[i].numOfGuests,
            DateTime.parseTimestamp(reservations[i].dateTime)
        );
    }
    
    
    /*NOT WORKING*/
    /*function readAll() view public returns(uint , string memory, uint, uint256) {
        for (uint i = 0; i < reservations.length; i++) {
            return (
                reservations[i].id,
                reservations[i].name,
                reservations[i].numOfGuests,
                DateTime.parseTimestamp(reservations[i].dateTime)
            );
        }
    }*/
    
    function update(uint id, string memory name, uint numOfGuests, uint8 _day, uint8 _month, uint16 _year, uint8 _hour, uint8 _minutes) public {
        uint i = find(id);
        
        reservations[i].name = name;
        reservations[i].numOfGuests = numOfGuests;
        reservations[i].dateTime = DateTime.toTimestamp(_year,_month,_day,_hour,_minutes);
    }
    
    function remove(uint id) public {
        uint i = find(id);
        delete reservations[i];
    }
    
    function find(uint id) view internal returns(uint){
        for(uint i=0; i<reservations.length; i++){
            if(reservations[i].id == id) {
                return i;
            }
        }
        revert('Reservation does not exist!');
    }
}