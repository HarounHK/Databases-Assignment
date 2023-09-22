--Subquery 1
--Displaying name and role of staff members involved in an order
select staff_name,staff_role 
from staff 
where staff_no in 
( 
	select item_staff_no 
	from "Order"
);

--Subquery 2
--Displaying the items that are of the brand apple along with the price
select brand_name, item_name, item_price
from item join item_info on item_infoid = item_info_item_infoid
where item_info_item_infoid in 
(
    select item_infoid
    from item_info
    where brand_name = 'Apple'
);




