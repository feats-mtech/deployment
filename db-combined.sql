drop table if exists user_account;
drop table if exists recipe;
drop table if exists recipe_cooking_step;
drop table if exists recipe_ingredients;
drop table if exists user_ingredients;
drop table if exists recipe_review;

-- id is a running number...
create table if not exists user_account(
	id serial,
	name VARCHAR not null,
	password VARCHAR not null,
	display_name VARCHAR not null,
	email VARCHAR not null,
	status INTEGER not null,
	role INTEGER not null,
	create_datetime timestamp with time zone not null,
	update_datetime timestamp with time zone not null,

  	primary key (id)
);

-- id is a running number...
create table if not exists recipe(
	id serial,
	creator_id INTEGER not null,
	name VARCHAR not null,
	image VARCHAR,
	description VARCHAR,
	cookingTimeInSec INTEGER not null,
	difficultyLevel INTEGER not null,
	rating double precision not null,
	status INTEGER not null,
	create_datetime timestamp with time zone not null,
	update_datetime timestamp with time zone not null,

  	primary key (id)
);
-- id is a running number...
create table if not exists recipe_review(
	id serial,
	recipe_id INTEGER not null,
	creator_id INTEGER not null,
	rating double precision not null,
	create_datetime timestamp with time zone not null,
	update_datetime timestamp with time zone not null,
	comments VARCHAR,
  	primary key (id)
);

-- combine key of id and recipe_id
create table if not exists recipe_cooking_step(
	id INTEGER,
	recipe_id INTEGER,
	description VARCHAR not null,
	image VARCHAR,
  	primary key (id,recipe_id)
	
);
-- id is labelled manually, with recipe Id, both together is the primary key...
create table if not exists recipe_ingredients(
	id INTEGER,
	recipe_id INTEGER,
	name VARCHAR not null,
	quantity DOUBLE precision not null,
	uom VARCHAR not null,
  	primary key (id,recipe_id)
);

-- id is labelled manually, with recipe Id, both together is the primary key...
create table if not exists user_ingredients(
	id serial,
	user_id INTEGER not null,
	name VARCHAR not null,
	quantity DOUBLE precision not null,
	uom VARCHAR not null,
	expiry_date date not null,
	create_datetime timestamp with time zone not null,
	update_datetime timestamp with time zone not null,
  	primary key (id)
);

