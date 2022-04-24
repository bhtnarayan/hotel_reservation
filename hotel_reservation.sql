/* table database and use database. */

CREATE  DATABASE  `hotel_reservation`;

USE `hotel_reservation`;

/* table for customers. */

CREATE TABLE `Customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` varchar(1) check (gender in ('M', 'F', 'O')),
  `address` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(20) NOT NULL,
  `phone` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`customer_id`)
  );
  
 /* insert value in customers table. */
  
INSERT INTO `Customer` VALUES (1,'Ram','2054-03-22','M','Thamel','Kathmandu','Bagmati','9847090900');
INSERT INTO `Customer` VALUES 
(2,'Shyam','2054-06-22','M','Kalikanagar','Butwal', 'Lumbini','983232322');
INSERT INTO `Customer` VALUES (3,'Hari','2054-03-02','M','Lakeside','Pokhara','Gandagi','9867162722');

/* create table for room */

CREATE TABLE `Room` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_type` varchar(50) NOT NULL,
  `room_size` varchar(50) NOT NULL,
  `room_price` decimal(4,2) NOT NULL,
  `room_status` bool NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`room_id`)
);

/* create table for booking */

CREATE TABLE `Booking` (
  `booking_id` tinyint(4) AUTO_INCREMENT NOT NULL,
  `customer_id` int,
  `room_id` int,
  `booking_status` varchar(50) NOT NULL,
  `booking_time` datetime default current_timestamp ON UPDATE 			current_timestamp NOT NULL,
  `arrival_time` datetime NOT NULL,
  `departure_time` datetime NOT NULL,
  `total_adults` int,
  `total_children` int,
  PRIMARY KEY (`booking_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE SET NULL, 
  FOREIGN KEY (`room_id`) REFERENCES `Room`(`room_id`) ON DELETE SET NULL
) ;




/* create table for invoices. */

CREATE TABLE `Invoices` (
  `invoice_id` int(11) AUTO_INCREMENT NOT NULL,
  `booking_id` tinyint(4),
  `customer_id` int(11) NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
    FOREIGN KEY (`booking_id`) REFERENCES `booking`(`booking_id`) ON DELETE SET NULL,
  FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE

);

/* create table for payment methods. */

CREATE TABLE `Payment_methods` (
  `payment_method_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
);

/* create table for payments. */

CREATE TABLE `Payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  PRIMARY KEY (`payment_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON UPDATE CASCADE,
  FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`payment_method_id`)
);



