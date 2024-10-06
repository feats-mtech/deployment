drop table if exists user_account;
drop table if exists recipe;
drop table if exists recipe_cooking_step;
drop table if exists recipe_ingredients;
drop table if exists user_ingredients;
drop table if exists recipe_review;

-- id is a running number...
CREATE TABLE IF NOT EXISTS user_account(
	id SERIAL,
	name VARCHAR not null,
	password VARCHAR not null,
	display_name VARCHAR not null,
	email VARCHAR not null,
	status INTEGER not null,
	role INTEGER not null,
	create_datetime TIMESTAMP WITH TIME ZONE not null,
	update_datetime TIMESTAMP WITH TIME ZONE not null,

  	primary key (id)
);

-- id is a running number...
CREATE TABLE IF NOT EXISTS recipe(
	id serial,
	creator_id INTEGER not null,
	name VARCHAR not null,
	image VARCHAR,
	description VARCHAR,
	cookingTimeInSec INTEGER not null,
	difficultyLevel INTEGER not null,
	rating DOUBLE precision not null,
	status INTEGER not null,
	create_datetime TIMESTAMP WITH TIME ZONE not null,
	update_datetime TIMESTAMP WITH TIME ZONE not null,

  	primary key (id)
);
-- id is a running number...
CREATE TABLE IF NOT EXISTS recipe_review(
	id SERIAL,
	recipe_id INTEGER not null,
	creator_id INTEGER not null,
	rating DOUBLE PRECISION not null,
	create_datetime TIMESTAMP WITH TIME ZONE not null,
	update_datetime TIMESTAMP WITH TIME ZONE not null,
	comments VARCHAR,
  	primary key (id)
);

-- combine key of id and recipe_id
CREATE TABLE IF NOT EXISTS recipe_cooking_step(
	id INTEGER,
	recipe_id INTEGER,
	description VARCHAR not null,
	image VARCHAR,
  	primary key (id,recipe_id)
	
);
-- id is labelled manually, with recipe Id, both together is the primary key...
CREATE TABLE IF NOT EXISTS recipe_ingredients(
	id INTEGER,
	recipe_id INTEGER,
	name VARCHAR not null,
	quantity DOUBLE precision not null,
	uom VARCHAR not null,
  	primary key (id,recipe_id)
);

-- id is labelled manually, with recipe Id, both together is the primary key...
CREATE TABLE IF NOT EXISTS user_ingredients(
	id SERIAL,
	user_id INTEGER not null,
	name VARCHAR not null,
	quantity DOUBLE PRECISION not null,
	uom VARCHAR not null,
	expiry_date DATE not null,
	create_datetime TIMESTAMP WITH TIME ZONE not null,
	update_datetime TIMESTAMP WITH TIME ZONE not null,
  	primary key (id)
);