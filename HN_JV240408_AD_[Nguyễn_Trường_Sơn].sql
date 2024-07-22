-- Tạo CSDL tên QUANLYBANHANG . 
create database quanlybanhang;
use quanlybanhang;

-- 1. Bảng CUSTOMERS [5 điểm] Trường email, phone không được trùng lặp.

create table customers (
	customer_id varchar(4) primary key not null,
    name varchar(100) not null,
    email varchar(100) unique not null,
    phone varchar(25) unique not null,
    address varchar(255) not null
); 

-- 2. Bảng ORDERS [5 điểm] Trường `customer_id` là khoá ngoại tham chiếu đến khoá chính của bảng `CUSTOMERS`
create table orders (
	order_id varchar(4) primary key not null,
    customer_id varchar(4) not null,
    foreign key (customer_id) references customers (customer_id),
    order_date date not null,
    total_amount double not null
);

-- 3. Bảng PRODUCTS [5 điểm]
create table products (
	product_id varchar(4) primary key not null,
    name varchar(255) not null,
    description text ,
    price double not null,
    status bit(1) not null
);

-- 4. Bảng ORDERS_DETAILS [5 điểm]
create table orders_details(
	primary key (order_id, product_id),
	order_id varchar(4) not null,
    foreign key (order_id) references orders(order_id),
    product_id varchar(4) not null,
    foreign key (product_id) references products(product_id),
    quantity int(11) not null,
    price double not null
);

-- Bài 2: Thêm dữ liệu [20 điểm]:
-- Thêm dữ liệu vào các bảng như sau :
-- Bảng CUSTOMERS [5 điểm] :
insert into customers ( customer_id, name, email, phone, address) values
('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '0984756322', 'Cầu Giấy, Hà Nội'),
('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '0984875926', 'Ba Vì,Hà Nội'),
('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '0904725784', 'Mộc Châu, Sơn La'),
('C004', 'Phạm Ngọc Anh','anhpn@gmail.com', '0984635365', 'Vinh, Nghệ An'),
('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '0989735624', 'Hai Bà Trưng, Hà Nội');


-- Bảng PRODUCTS [5 điểm]:
insert into products (product_id, name, description, price, status)
values ('P001', 'iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5, RAM8GB', 14999999, 1),
       ('P003', 'Macbook Pro M2', '8CPU 10CPU 8GB 256GB', 28999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
       ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000, 1);

-- bảng ORDERS [5 điểm]:
insert into orders (order_id, customer_id, total_amount, order_date)
values ('H001', 'C001', 52999997, str_to_date('22/02/2023','%d/%m/%Y')),
       ('H002', 'C001', 80999997, str_to_date('11/03/2023','%d/%m/%Y')),
       ('H003', 'C002', 54359998, str_to_date('22/01/2023','%d/%m/%Y')),
       ('H004', 'C003', 102999995, str_to_date('14/03/2023','%d/%m/%Y')),
       ('H005', 'C003', 80999997, str_to_date('12/03/2022','%d/%m/%Y')),
       ('H006', 'C004', 110449994, str_to_date('01/02/2023','%d/%m/%Y')),
       ('H007', 'C004', 79999996, str_to_date('29/03/2023','%d/%m/%Y')),
       ('H008', 'C004', 29999998, str_to_date('14/02/2023','%d/%m/%Y')),
       ('H009', 'C005', 28999999, str_to_date('10/01/2023','%d/%m/%Y')),
       ('H010', 'C005', 149999994, str_to_date('01/04/2023','%d/%m/%Y'));
       
-- select * from orders_details;
# bảng Orders_details [5 điểm]:
insert into orders_details (order_id, product_id, price, quantity)
values ('H001', 'P002', 14999999, 1),
       ('H001', 'P004', 18999999, 2),
       ('H002', 'P001', 22999999, 1),
       ('H002', 'P003', 28999999, 2),
       ('H003', 'P004', 18999999, 2),
       ('H003', 'P005',  4090000, 4),
       ('H004', 'P002', 14999999, 3),
       ('H004', 'P003', 28999999, 2),
       ('H005', 'P001', 22999999, 1),
       ('H005', 'P003', 28999999, 2),
       ('H006', 'P005',  4090000, 5),
       ('H006', 'P002', 14999999, 6),
       ('H007', 'P004', 18999999, 3),
       ('H007', 'P001', 22999999, 1),
       ('H008', 'P002', 14999999, 2),
       ('H009', 'P003', 28999999, 1),
       ('H010', 'P003', 28999999, 2),
       ('H010', 'P001', 22999999, 4);
       
# Bài 3: Truy vấn dữ liệu [30 điểm]:
-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers . [4 điểm]
select name as 'tên' , email , 
phone as 'số điện thoại' , address as 'địa chỉ' 
from customers;

-- 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng). [4 điểm]
select c.name, c.phone, c.address from customers c
inner join orders o on c.customer_id = o.customer_id
where month(o.order_date) = 3 and year(o.order_date) = 2023;

-- 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ). [4 điểm]
select month(order_date) as 'tháng',  format(round(sum(total_amount)),1,'vi_VN') as 'Tổng doanh thu'
from orders where year(order_date) = 2023 
group by month(order_date) 
order by month(order_date) asc;

-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại). [4 điểm]
select c.name as 'Tên khách hàng', c.address as 'Địa chỉ',
c.email , c.phone as 'Số điện thoại'
from customers c where c.customer_id  
not in (
    select distinct customer_id 
    from orders o
    where month(o.order_date) = 2 and year(o.order_date) = 2023
);


-- 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
select p.product_id as 'Mã sản phẩm', p.name as 'Tên sản phẩm' , sum(od.quantity) as 'Số lượng bán ra'
from products p inner join orders_details od on p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
where month(o.order_date) = 3 and year(o.order_date) = 2023
group by p.product_id , p.name;

-- 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu
-- (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
select c.customer_id as 'Mã khách hàng', c.name as 'Tên khách hàng', format(round(sum(total_amount)),1,'vi_VN') as 'Mức chi tiêu' 
from customers c inner join orders o on c.customer_id = o.customer_id
where year(o.order_date) = 2023
group by c.customer_id, c.name
order by sum(o.total_amount) desc;


-- 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên 
-- (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]
select c.name as 'Người mua', o.total_amount as 'Tổng tiền',
 o.order_date as 'Ngày tạo', 
sum(od.quantity) as 'Tổng số lượng' 
from orders_details od 
inner join orders o on od.order_id = o.order_id
inner join customers c on o.customer_id = c.customer_id
group by o.order_id, c.name, o.total_amount, o.order_date
having sum(od.quantity) >= 5;

# Bài 4: Tạo View, Procedure [30 điểm]:
-- 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn . [3 điểm]
create view get_info_order as
select c.name, c.phone, c.address, o.total_amount, o.order_date
from orders o inner join customers c on o.customer_id = c.customer_id;

-- select * from get_info_order;

-- 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt. [3 điểm]
create view get_info_customers as
select c.name, c.address, c.phone, count(o.order_id) AS total_order
FROM customers c
         left join orders o ON c.customer_id = o.customer_id
group by c.customer_id;

-- select * from get_info_customers;

-- 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.
create view show_info_product as
select p.name as 'Tên sản phẩm', p.description as 'Mô tả' , format(round(p.price),1,'vi_VN') as 'Giá tiền' , sum(od.quantity) as 'Tổng số lượng đã bán ra'
from products p inner join orders_details od on p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
group by p.product_id;

-- select * from show_info_product;
-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
create index index_phone on customers(phone);
create index inemailemaildex_email on customers(email);

-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
delimiter //
create procedure getAllCustomers(
	in customer_id_in varchar(4)
)
begin 
	select * from customers where customer_id = customer_id_in;
end; //
delimiter ;

-- call getAllCustomers('C001');

-- 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
delimiter //
create procedure getAllProducts ()
begin
	select * from products;
end; //
	
delimiter ;

-- call getAllproducts();

-- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
delimiter //
create procedure getListOrdersByCustomer(
	in customer_id_in varchar(4)
)
begin
	select * from orders where customer_id = customer_id_in;
end;//

delimiter ;

-- call getListOrdersByCustomer('C003');


-- 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
-- tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
delimiter //
create procedure create_new_order(
	in customer_id_in varchar(4), 
	in total_amount_in double, 
	in order_date_in date
)
begin
    declare next_id int;
    declare new_id varchar(4);
    
    -- Lấy order_id hiện tại lớn nhất (bỏ qua ký tự đầu) và tăng lên 1
    set next_id = ifnull((select max(cast(substring(order_id, 2) as unsigned)) from orders), 0) + 1;
    
    -- Tạo order_id mới
    set new_id = concat('H', lpad(next_id, 3, '0'));
    
    -- thêm order mới
    insert into orders(order_id, customer_id, total_amount, order_date) VALUES (new_id, customer_id_in, total_amount_in, order_date_in);
    -- Hiển thị mã đơn hàng vừa tạo
    SELECT new_id as 'Mã đơn hàng mới';
    
end;//

delimiter ;

-- call create_new_order('C005', 59999998,  str_to_date('22/07/2023','%d/%m/%Y'));
-- select * from orders;

-- 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
-- thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
delimiter //
create procedure getStatisticsSalesOfEachProduct(
	in fromDate date ,
    in toDate date 
)
begin 
	select p.product_id, p.name, sum(od.quantity) as total_quantity_sold
    from products p inner join orders_details od on p.product_id = od.product_id
	inner join orders o on o.order_id = od.order_id
    where o.order_date between fromDate and toDate
    group by p.product_id;
end; //
delimiter ;

-- call getStatisticsSalesOfEachProduct(str_to_date('22/02/2023','%d/%m/%Y'), str_to_date('01/04/2023','%d/%m/%Y'));

-- 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
-- giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]
delimiter //
create procedure getStatisticsQuantityProduct(
	in monthOfSale int,
    in yearOfSale int
)
begin
	select p.product_id, p.name, sum(od.quantity) as total_quantity_sold
    from products p inner join orders_details od on p.product_id = od.product_id
	inner join orders o on o.order_id = od.order_id
    where month(o.order_date) = monthOfSale and year(o.order_date) = yearOfDate
    group by p.product_id
    order by total_quantity_sold desc;
end; //

delimiter ;

-- call getStatisticsQuantityProduct('2', '2023');
