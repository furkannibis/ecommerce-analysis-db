CREATE DATABASE eadb;

CREATE TABLE product_types (
	product_type_uuid UUID PRIMARY KEY NOT NULL,
	product_type_name VARCHAR(30) NOT NULL UNIQUE,
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
	is_deleted BOOLEAN NOT NULL DEFAULT(FALSE)
);

CREATE TABLE product_sub_categories (
	product_sub_category_uuid UUID PRIMARY KEY NOT NULL,
	product_sub_category_name VARCHAR(30) NOT NULL UNIQUE,
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
	is_deleted BOOLEAN NOT NULL DEFAULT(FALSE)
);

CREATE TABLE product_types_product_sub_categories (
	product_type_uuid UUID REFERENCES product_types(product_type_uuid) NOT NULL,
	product_sub_category_uuid UUID REFERENCES product_sub_categories(product_sub_category_uuid) NOT NULL,
	PRIMARY KEY(product_type_uuid, product_sub_category_uuid)
);

CREATE TABLE product_categories (
	product_category_uuid UUID PRIMARY KEY NOT NULL,
	product_category_name VARCHAR(30) NOT NULL UNIQUE,
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
	is_deleted BOOLEAN NOT NULL DEFAULT(FALSE)
);

CREATE TABLE product_sub_categories_product_categories (
	product_sub_category_uuid UUID NOT NULL REFERENCES product_sub_categories(product_sub_category_uuid),
	product_category_uuid UUID NOT NULL REFERENCES product_categories(product_category_uuid),
	PRIMARY KEY (product_sub_category_uuid, product_category_uuid)
);

CREATE TABLE products (
	product_uuid UUID PRIMARY KEY NOT NULL,
	product_name VARCHAR(100) NOT NULL,
	product_type UUID REFERENCES product_types(product_type_uuid),
	creation_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
	is_deleted BOOLEAN NOT NULL DEFAULT(FALSE)
);

CREATE TABLE attributes (
	attribute_uuid UUID PRIMARY KEY NOT NULL,
	attribute_name VARCHAR(30) NOT NULL
);

CREATE TABLE product_attribute (
	product_uuid UUID NOT NULL REFERENCES products(product_uuid),
	attribute_uuid UUID NOT NULL REFERENCES attributes(attribute_uuid),
	value VARCHAR(30) NOT NULL,
	PRIMARY KEY(product_uuid, attribute_uuid)
);

CREATE TABLE product_type_attribute (
	product_type_uuid UUID NOT NULL REFERENCES product_types(product_type_uuid),
	attribute_uuid UUID NOT NULL REFERENCES attributes(attribute_uuid),
	is_required BOOLEAN NOT NULL DEFAULT(TRUE),
	PRIMARY KEY(product_type_uuid, attribute_uuid)
);












