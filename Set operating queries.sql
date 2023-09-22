--set operating queries

--Number 1 (Intersect)
--displaying item id of items that cost over 200 and that have stock of more than 10
select item_id from item 
where item_price > 200
intersect
select item_item_id from stock 
where stock_quantity > 10
order by item_id asc;

--Number 2 (Union)
--displaying item id of items that cost over 200 or that have stock of more than 10
select item_id from item 
where item_price > 200
union
select item_item_id from stock 
where stock_quantity > 10
order by item_id asc;

--Number 3 (Except)
--displaying item id of items that have been over ordered expect the ones that cost below 100
select item_item_id from "Order" 
where order_id > 0
except
select item_id from item 
where item_price < 100
order by item_item_id asc;
