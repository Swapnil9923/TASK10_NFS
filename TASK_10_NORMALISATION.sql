select * from invoice_line


select * from track

select * from album

select * from genre

select * from media_type

select * from artist

select * from invoice

select * from playlist_track

------this is 1NF
select distinct track_id,unit_price,invoice_line_id from invoice_line

create table data_invoice 
as select distinct track_id,unit_price,invoice_line_id from invoice_line

select * from data_invoice

select distinct name,album_id,media_type_id,composer,milliseconds,bytes,unit_price from track

create table name_compose
as select distinct name,album_id,media_type_id,composer,milliseconds,bytes,unit_price from track

select * from name_compose

select distinct album_id,title,artist_id from album

create table album_title
as select distinct album_id,title,artist_id from album

select * from album_title

create table NF 
as 
select  distinct d.track_id,d.unit_price,d.invoice_line_id,a.album_id,a.title,a.artist_id,n.composer,n.media_type_id,n.milliseconds from data_invoice as d
inner join name_compose as n
on d.unit_price=n.unit_price
inner join album_title as a
on n.album_id=a.album_id

select * from NF
-------------This is 2NF---
select artist_id,composer from NF

create table artist_name
as select artist_id,composer from NF

select * from artist_name

select distinct album_id,title,artist_id from NF

create table album_S
as select distinct album_id,title,artist_id from NF

select * from album_s


create table album_track
as select track_id,album_id,composer,media_type_id,milliseconds,unit_price
from NF

select * from album_track

create table line_invoice
as select invoice_line_id,track_id,unit_price from NF

select * from line_invoice

---------This is 3NF----
ALTER TABLE album_track DROP COLUMN composer;

select * from album_track
CREATE TABLE track_info AS
SELECT 
    at.track_id,
    at.milliseconds,
    at.media_type_id,
    at.unit_price,
    a.album_id,
    a.title,
    a.artist_id
FROM 
    album_track at
JOIN 
    album_s a ON at.album_id = a.album_id;

select * from track_info
