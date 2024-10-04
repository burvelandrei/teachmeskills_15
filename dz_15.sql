-- Задача 1: Создание и заполнение таблиц
create table authors
(
    id int primary key,
    first_name varchar(50),
    last_name varchar(50)
);

create table books
(
    id int primary key,
    title varchar(50),
    author_id int,
    publication_year int,
    foreign key(author_id) references authors(id)
)

create table sales
(
	id int primary key,
	book_id int,
	quantity int,
	foreign key(book_id) references books(id)
);

insert into authors (id, first_name, last_name)
values (1, 'Михаил', 'Булгаков'),
	   (2, 'Николай', 'Гоголь'),
	   (3, 'Александр', 'Дюма'),
	   (4, 'Виктор', 'Гюго'),
	   (5, 'Александр', 'Пушкин');

insert into books(id, title, author_id, publication_year)
values (1, 'Мастер и Маргарита', 1, 1940),
	   (2, 'Собачье сердце', 1, 1925),
	   (3, 'Мёртвые души', 2, 1842),
	   (4, 'Граф Монте-Кристо', 3, 1845),
	   (5, 'Евгений Онегин', 5, 1837),
	   (6, 'Отверженные', 4, 1862);

insert into sales(id, book_id, quantity)
values (1, 1, 22),
	   (2, 2, 150),
	   (3, 3, 2),
	   (4, 4, 85),
	   (5, 5, 1500),
	   (6, 6, 128);


-- Задача 2: Использование JOIN
select books.title as book_title,
	authors.first_name as first_name,
	authors.last_name as last_name
from authors
inner join books on books.author_id = authors.id;

select authors.first_name as first_name,
	authors.last_name as last_name,
	books.title as book_title
from books
left join authors on books.author_id = authors.id;

select books.title as book_title,
	authors.first_name as first_name,
	authors.last_name as last_name
from books
right join authors on books.author_id = authors.id;


-- Задача 3: Множественные JOIN
select books.title as book_title,
	authors.first_name as first_name,
	authors.last_name as last_name,
	sales.quantity as quantity
from books
inner join authors on books.author_id = authors.id
inner join sales on books.id = sales.book_id;

select authors.first_name as first_name,
	authors.last_name as last_name,
	books.title as book_title,
	sales.quantity as quantity
from authors
left join books on books.author_id = authors.id
left join sales on books.id = sales.book_id;


-- Задача 4: Агрегация данных с использованием JOIN
select authors.first_name as first_name,
	authors.last_name as last_name,
	sum(sales.quantity) as sum_quantity
from authors
inner join books on books.author_id = authors.id
inner join sales on books.id = sales.book_id
group by authors.first_name, authors.last_name;

select authors.first_name as first_name,
	authors.last_name as last_name,
	sum(sales.quantity) as sum_quantity
from authors
left join books on books.author_id = authors.id
left join sales on books.id = sales.book_id
group by authors.first_name, authors.last_name;


-- Задача 5: Подзапросы и JOIN
select authors.first_name as first_name,
	authors.last_name as last_name
from authors
inner join books on books.author_id = authors.id
inner join sales on books.id = sales.book_id
where sales.quantity = (select max(quantity) from sales);

select books.title as book_title
from books
inner join sales on books.id = sales.book_id
where sales.quantity > (select avg(quantity) from sales);