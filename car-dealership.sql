create table car (
	car_id SERIAL primary key,
	car_make VARCHAR(100),
	car_model VARCHAR(100),
	car_price NUMERIC(8,2)
);

create table part (
	part_id SERIAL primary key,
	part_name VARCHAR(150),
	part_price NUMERIC(8,2)
);

create table service_ticket (
	service_ticket_id SERIAL primary key,
	car_id INTEGER not null,
	part_id INTEGER,
	foreign key(car_id) references car(car_id),
	foreign key(part_id) references part(part_id)
);

create table invoice (
	invoice_id SERIAL primary key,
	invoice_total NUMERIC(9,2),
	car_id INTEGER not null,
	foreign key(car_id) references car(car_id)
);

create table mechanic (
	mechanic_id SERIAL primary key,
	mech_fname VARCHAR(100),
	mech_lname VARCHAR(100),
	service_ticket_id INTEGER not null,
	foreign key(service_ticket_id) references service_ticket(service_ticket_id)
);

create table salesperson (
	sales_id SERIAL primary key,
	sales_fname VARCHAR(100),
	sales_lname VARCHAR(100),
	car_id INTEGER not null,
	invoice_id INTEGER not null,
	foreign key(car_id) references car(car_id),
	foreign key(invoice_id) references invoice(invoice_id)
);

create table customer (
	customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	billing_info VARCHAR(150),
	car_id INTEGER,
	invoice_id INTEGER not null,
	service_ticket_id INTEGER,
	foreign key(car_id) references car(car_id),
	foreign key(invoice_id) references invoice(invoice_id),
	foreign key(service_ticket_id) references service_ticket(service_ticket_id)
);


-- Insert data into tables

-- Insert car info
insert into car (car_id, car_make, car_model, car_price)
VALUES(1, 'Toyota', 'Corolla', 30000.00);
insert into car (car_id, car_make, car_model, car_price)
VALUES(2, 'Honda', 'Civic', 35000.00);

-- Insert parts info
-- Use a function to insert info into parts table
create or replace function add_part(_part_id INTEGER, _part_name VARCHAR, _part_price NUMERIC(8,2))
returns void
as $MAIN$
begin 
	insert into part(part_id,part_name,part_price)
	values (_part_id,_part_name,_part_price);
end;
$MAIN$
language plpgsql;
-- and call the function 
select add_part(1, 'Goodyear Tire', 500.00);
select add_part(2, 'Windshield wipers', 100.00);


-- Insert service_ticket info
insert into service_ticket (service_ticket_id, car_id, part_id)
VALUES(1, 1, 1);
insert into service_ticket (service_ticket_id, car_id, part_id)
VALUES(2, 2, 2);

-- Insert invoice info
insert into invoice(invoice_id, invoice_total, car_id)
VALUES(1, 40000.00, 1);
insert into invoice(invoice_id, invoice_total, car_id)
VALUES(2, 45000.00, 2);

-- Insert mechanic info
insert into mechanic(mechanic_id, mech_fname, mech_lname, service_ticket_id)
VALUES(1, 'Jimmy', 'Mech', 1);
insert into mechanic(mechanic_id, mech_fname, mech_lname, service_ticket_id)
VALUES(2, 'Tommy', 'Jones', 2);

-- Insert salesperson info
insert into salesperson(sales_id, sales_fname, sales_lname, car_id, invoice_id)
VALUES(1, 'Jake', 'Smith', 1, 1);
insert into salesperson(sales_id, sales_fname, sales_lname, car_id, invoice_id)
VALUES(2, 'Petunia', 'Bacon', 2, 2);

-- Insert customer info
insert into customer(customer_id, first_name, last_name, billing_info, car_id, invoice_id, service_ticket_id)
VALUES(1, 'Lily', 'Daniel', '1234-4567-8910 150 1/23', 1, 1, NULL);
insert into customer(customer_id, first_name, last_name, billing_info, car_id, invoice_id, service_ticket_id)
VALUES(2, 'Andrew', 'Reeves', '1234-4567-8911 249 1/24', 2, 2, 1);



select * from customer;




