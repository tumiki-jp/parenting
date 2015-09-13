
-- 
-- psql -h localhost -d parenting -U [username] -f main/config/postgresql-init.sql
--

----------------------------------------------
-- MovieSiteData
----------------------------------------------
DROP TABLE IF EXISTS movie_site_data;

CREATE TABLE movie_site_data (
  id SERIAL primary key,
  url text not null,
  title text not null,
  description text,
  tags text,
  release_date timestamp with time zone,
  view_count int,
  like_count int,
  dislike_count int,
  comments text,
  thumbnail text
);

GRANT ALL ON movie_site_data TO parenting_user;
GRANT ALL ON movie_site_data_id_seq TO parenting_user;


----------------------------------------------
-- CookSiteData
----------------------------------------------
DROP TABLE IF EXISTS cook_site_data;

CREATE TABLE cook_site_data (
  id SERIAL primary key,
  url text not null,
  title text not null,
  description text,
  tags text,
  release_date timestamp with time zone,
  thumbnail text
);

GRANT ALL ON cook_site_data TO parenting_user;
GRANT ALL ON cook_site_data_id_seq TO parenting_user;


----------------------------------------------
-- QASiteData
----------------------------------------------
DROP TABLE IF EXISTS qa_site_data;

CREATE TABLE qa_site_data (
  id SERIAL primary key,
  url text not null,
  title text not null,
  tags text,
  update_date timestamp with time zone
);

GRANT ALL ON qa_site_data TO parenting_user;
GRANT ALL ON qa_site_data_id_seq TO parenting_user;
