--Author: Haroun Kassouri, C21508813
--Date: 17/04/2023

--Databases Assignment

--dropping tables
drop table stock;
drop table "Order";
drop table item;
drop table item_info;
drop table staff;
drop table customer;

--Showing that the tables have been created and they have the information inside
select * from customer;
select * from item;
select * from item_info;
select * from "Order";
select * from staff;
select * from stock;


CREATE TABLE customer 
(
    customer_id           INT NOT NULL,
    customer_name         VARCHAR(50) NOT NULL,
    custumer_phone_number NUMERIC(20) NOT NULL,
    customer_email        VARCHAR(50) NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_id );

ALTER TABLE customer ADD CONSTRAINT customer_customer_id_un UNIQUE ( customer_id );

CREATE TABLE item 
(
    item_id               INT NOT NULL,
    item_serial           VARCHAR(50) NOT NULL,
    item_name             VARCHAR(30) NOT NULL,
    item_price            NUMERIC(10,2) NOT NULL,
    item_info_item_infoid INT NOT NULL,
    staff_staff_no        INT NOT NULL
);

ALTER TABLE item
    ADD CONSTRAINT item_pk PRIMARY KEY ( item_id,
                                         item_info_item_infoid,
                                         staff_staff_no );

CREATE TABLE item_info 
(
    item_infoid INT NOT NULL,
    item_type   VARCHAR(40) NOT NULL,
    brand_name  VARCHAR(40) NOT NULL
);

ALTER TABLE item_info ADD CONSTRAINT item_info_pk PRIMARY KEY ( item_infoid );

CREATE TABLE "Order" 
(
    order_id                   INT NOT NULL,
    order_date                 DATE NOT NULL,
    order_quantity             INT NOT NULL,
    customer_customer_id       INT NOT NULL,
    item_item_id               INT NOT NULL,
    item_item_info_item_infoid INT NOT NULL,
    item_staff_no              INT NOT NULL
);

ALTER TABLE "Order"
    ADD CONSTRAINT order_pk PRIMARY KEY ( order_id,
                                          customer_customer_id,
                                          item_item_id,
                                          item_item_info_item_infoid,
                                          item_staff_no );

CREATE TABLE staff 
(
    staff_no   INT NOT NULL,
    staff_name VARCHAR(30) NOT NULL,
    staff_role VARCHAR(30) NOT NULL
);

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staff_no );

CREATE TABLE stock 
(
    stock_id                   INT NOT NULL,
    stock_description          VARCHAR(255) NOT NULL,
    stock_quantity             INT NOT NULL,
    item_item_id               INT NOT NULL,
    item_item_info_item_infoid INT NOT NULL,
    item_staff_staff_no        INT NOT NULL
);

CREATE UNIQUE INDEX stock__idx ON
    stock (
        item_item_id
    ASC,
        item_item_info_item_infoid
    ASC,
        item_staff_staff_no
    ASC );

ALTER TABLE stock ADD CONSTRAINT stock_pk PRIMARY KEY ( stock_id );

ALTER TABLE item
    ADD CONSTRAINT item_item_info_fk FOREIGN KEY ( item_info_item_infoid )
        REFERENCES item_info ( item_infoid );

ALTER TABLE item
    ADD CONSTRAINT item_staff_fk FOREIGN KEY ( staff_staff_no )
        REFERENCES staff ( staff_no );

ALTER TABLE "Order"
    ADD CONSTRAINT order_customer_fk FOREIGN KEY ( customer_customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_item_fk FOREIGN KEY ( item_item_id,
                                               item_item_info_item_infoid,
                                               item_staff_no )
        REFERENCES item ( item_id,
                          item_info_item_infoid,
                          staff_staff_no );

ALTER TABLE stock
    ADD CONSTRAINT stock_item_fk FOREIGN KEY ( item_item_id,
                                               item_item_info_item_infoid,
                                               item_staff_staff_no )
        REFERENCES item ( item_id,
                          item_info_item_infoid,
                          staff_staff_no );
                         
-------------------------------------------------
--Inserting information into the tables
-------------------------------------------------
                       
INSERT INTO customer (customer_id, customer_name, custumer_phone_number, customer_email) 
VALUES
(1, 'Jeremy Donohan', '089234786', 'jeremydonohan@gmail.com'),
(2, 'Elena Forbes', '085693478', 'elena.forbes1@yahoo.ie'),
(3, 'Mathew Gilbert', '086458934', 'mathew.gilbert@gmx.com'),
(4, 'Stefan Stevenson', '083243502', 'stefan.stevenson@gmail.com'),
(5, 'Jeffery Clarke', '086254674', 'jeff.clk12@gmail.com'),
(6, 'julia Roberts', '0879786', 'juliarobertsbusiness@yahoo.ie'),
(7, 'Henry James ', '089764359', 'henryofficial@gmail.com'),
(8, 'Jennifer Murphy', '083564876', 'jennmurph@outlook.ie');


INSERT INTO staff (staff_no, staff_name, staff_role) 
VALUES
(17, 'Oisin', 'Warehouse Supervisor'),
(18, 'Damo', 'Order Picker'),
(19, 'Charlie', 'Warehouse Worker'),
(20, 'Harry', 'Sales Associate'),
(21, 'Thomas', 'Sales Associate');


INSERT INTO item_info (item_infoid, item_type, brand_name) 
VALUES
(1001, 'Iphone', 'Apple'),
(1002, 'Phone', 'Samsung'),
(1003, 'Earphones', 'Huawei'),
(1004, 'Chromebook', 'Dell'),
(1005, 'TV', 'Samsung');


INSERT INTO item (item_id, item_serial, item_name, item_price, item_info_item_infoid, staff_staff_no) 
VALUES
(101, 'X1001', 'iPhone 14', 999.00, 1001, 18),
(102, 'X1002', 'Samsung Galaxy A54', 449.99, 1002, 18),
(103, 'X1003', 'Huawei Freebuds 4', 59.99, 1003, 20),
(104, 'X1004', 'Dell Chromebook 11', 89.00, 1004, 19),
(105, 'X1005', 'iPad pro', 789.00, 1001, 20),
(106, 'X1006', 'Samsung TV', 1099.00, 1005, 19),
(107, 'X1007', 'Samsung Pro Curved TV', 1399.00, 1005, 21);


INSERT INTO "Order" (order_id, order_date, order_quantity, customer_customer_id, item_item_id, item_item_info_item_infoid, item_staff_no) 
VALUES
(100000, '2023-03-31', 2, 1, 101, 1001, 18),
(100001, '2023-04-04', 3, 2, 102, 1002, 18),
(100003, '2023-04-11', 4, 3, 103, 1003, 20),
(100008, '2023-04-12', 1, 4, 104, 1004, 19),
(100009, '2023-04-18', 1, 7, 101, 1001, 18),
(100010, '2023-04-19', 21, 6, 107, 1005, 21);


INSERT INTO stock (stock_id, stock_description, stock_quantity, item_item_id, item_item_info_item_infoid, item_staff_staff_no) 
VALUES
(1, 'In Stock, Brand new iPhone 14', 100, 101, 1001, 18),
(2, 'Low Stock, Refurbished Samsung Galaxy A54', 7, 102, 1002, 18),
(3, 'In Stock, On sale earphones', 50, 103, 1003, 20),
(4, 'Low Stock, Brand new Dell Chromebook 11', 5, 104, 1004, 19),
(5, 'Low Stock, Refurbished Ipad Pro', 4, 105, 1001, 20),
(6, 'In Stock, On Sale Samsung TV', 50, 106, 1005, 19),
(7, 'Low Stock, Full price Samsung Pro curved TV', 3, 107, 1005, 21);


