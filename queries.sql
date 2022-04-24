-------------Query------------
 
 /* 1. Select customer whose name start with the letter "A" or
ends with the letter "S" but should have the letter "K" */

 SELECT name from Customer WHERE name LIKE "A%[K]%S";
 
 
 /* 2. Customers who do not have any invoice yet but used the room */
 
SELECT name from Customer
 WHERE booking_id is NOT NULL AND
 booking_id in (
 SELECT booking_id from Booking
 Where booking_id NOT IN (
 SELECT booking_id from Invoices
 ));


/* 3. Number of rooms reserved on current date. */

SELECT count(room_id) from Room
WHERE is_available = false;


/* 4. Return the list of customers who reserved more than 2 rooms */

SELECT * from Customer
where (SELECT count(customer_id)
from Booking 
where customer_id in (SELECT distinct customer_id 
from Booking) > 2
);


/* 5. List of rooms which were reserved yesterday */

SELECT * from Room
Where room_id in (SELECT room_id 
from Booking WHERE booking_time = (date_sub(curdate(), interval 1 day))
); 


/* 6. Number of rooms and type of rooms available today */

SELECT count(room_id) from Room
WHERE room_status = true;

SELECT distinct room_type from Room
where room_status = true;


/* 7. Change the price of rooms for Fridays by 15% of current price */

UPDATE room_type 
SET room_price = room_price - 0.15 * room_price
WHERE weekday(curdate()) = 4; 


/* 8. Remove customers who have not booked any room in current year */

DELETE from Customer
WHERE customer_id not in (
SELECT distinct customer_id from Booking
WHERE year(booking_time) = year(curdate())
);


