pragma solidity >=0.7.0 <0.9.0;

import "contracts/DateTime.sol";

contract SimpleSmartContract {
    struct Reservation {
        uint id;
        string name;
        uint numOfGuests;
        uint256 dateTime;
    }
    
            struct _DateTime {
                uint16 year;
                uint8 month;
                uint8 day;
                uint8 hour;
                uint8 minute;
                uint8 second;
                uint8 weekday;
        }
    
    Reservation[] public reservations;
    
    
    uint public nextId;
    function create(string memory name, uint numOfGuests, uint8 _day, uint8 _month, uint16 _year, uint8 _hour, uint8 _minutes) public {
        reservations.push(Reservation(nextId, name, numOfGuests, DateTime.toTimestamp(_year,_month,_day,_hour,_minutes)));
        nextId++;
    }
    
    function read(uint id) view public returns(uint , string memory, uint, DateTime._DateTime memory) {
        for (uint16 i = 0; i < reservations.length; i++) {
            uint16 num = i + 2012;
            if (reservations[i].id == id) {
                return (
                    reservations[i].id,
                    reservations[i].name,
                    reservations[i].numOfGuests,
                    DateTime.parseTimestamp(reservations[i].dateTime)
                    );
            }
        }
    }
    
    
    /*NOT WORKING*/
    function readAll() view public returns(uint , string memory, uint, DateTime._DateTime memory) {
        for (uint i = 0; i < reservations.length; i++) {
            return (
                reservations[i].id,
                reservations[i].name,
                reservations[i].numOfGuests,
                DateTime.parseTimestamp(reservations[i].dateTime)
                );
        }
    }
    
    function update(uint id, string memory name, uint numOfGuests, uint8 _day, uint8 _month, uint16 _year, uint8 _hour, uint8 _minutes) public {
        for(uint i=0; i<reservations.length; i++) {
            if(reservations[i].id == id) {
                reservations[i].name = name;
                reservations[i].numOfGuests = numOfGuests;
                reservations[i].dateTime = DateTime.toTimestamp(_year,_month,_day,_hour,_minutes);
            }
        }
    }
    
    function remove(uint id) public {
        delete reservations[id];
    }
}