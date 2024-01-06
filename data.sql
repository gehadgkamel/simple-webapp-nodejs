create table posts (
  id serial primary key,
  title varchar(128),
  body varchar(512)
);

insert into posts (title, body) values
('Title One', 'Body one'),
('Title two', 'Body two'),
('Title three', 'Body three');

select * from posts;

TRUNCATE posts RESTART IDENTITY;
