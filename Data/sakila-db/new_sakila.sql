--
-- Table structure for table `actor`
--
DROP TABLE IF EXISTS `actor`;
CREATE TABLE `actor` (
  `actor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`actor_id`),
  KEY `ix_actor` (`first_name`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` int NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  CONSTRAINT `address_fk1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `country_id` smallint NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`city_id`),
  KEY `idx_fk_country_id` (`country_id`),
  CONSTRAINT `city_fk1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=603 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `country_id` smallint NOT NULL AUTO_INCREMENT,
  `country` varchar(50) NOT NULL,
  `last_update` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
       `customer_id` int NOT NULL AUTO_INCREMENT,
       `store_id` int NOT NULL,
       `first_name` varchar(45) NOT NULL,
       `last_name` varchar(45) NOT NULL,
       `email` varchar(50) DEFAULT NULL,
       `address_id` int NOT NULL,
       `active` char(1) NOT NULL DEFAULT 'Y',
       `create_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
       `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
       PRIMARY KEY (`customer_id`),
       KEY `idx_fk_address_id` (`address_id`),
       KEY `idx_fk_store_id` (`store_id`),
       KEY `idx_last_name` (`last_name`),
       CONSTRAINT `customer_fk1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`),
       CONSTRAINT `customer_fk2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `film`;
CREATE TABLE `film` (
  `film_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `release_year` varchar(4) DEFAULT NULL,
  `language_id` tinyint unsigned NOT NULL,
  `original_language_id` tinyint unsigned DEFAULT NULL,
  `rental_duration` tinyint unsigned NOT NULL DEFAULT '3',
  `rental_rate` decimal(4,2) NOT NULL DEFAULT '4.99',
  `length` smallint DEFAULT NULL,
  `replacement_cost` decimal(5,2) NOT NULL DEFAULT '19.99',
  `rating` varchar(10) DEFAULT 'G',
  `special_features` varchar(255) DEFAULT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`film_id`),
  KEY `idx_fk_language_id` (`language_id`),
  KEY `idx_fk_original_language_id` (`original_language_id`),
  CONSTRAINT `film_fk1` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`),
  CONSTRAINT `film_fk2` FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `film_actor`;
CREATE TABLE `film_actor` (
  `actor_id` int NOT NULL,
  `film_id` int NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`actor_id`,`film_id`),
  KEY `idx_fk_film_actor_actor` (`actor_id`),
  KEY `idx_fk_film_actor_film` (`film_id`),
  CONSTRAINT `film_actor_fk1` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`),
  CONSTRAINT `film_actor_fk2` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `film_category`;
CREATE TABLE `film_category` (
  `film_id` int NOT NULL,
  `category_id` tinyint unsigned NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`film_id`,`category_id`),
  KEY `idx_fk_film_category_category` (`category_id`),
  KEY `idx_fk_film_category_film` (`film_id`),
  CONSTRAINT `film_category_fk1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `film_text`;
CREATE TABLE `film_text` (
  `film_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`film_id`),
  CONSTRAINT `film_text_fk1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `film_id` int NOT NULL,
  `store_id` int NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`inventory_id`),
  KEY `idx_fk_film_id` (`film_id`),
  KEY `idx_fk_film_id_store_id` (`store_id`,`film_id`),
  CONSTRAINT `inventory_fk1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`),
  CONSTRAINT `inventory_fk2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4582 DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `language_id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `staff_id` int NOT NULL,
  `rental_id` int DEFAULT NULL,
  `amount` decimal(5,2) NOT NULL,
  `payment_date` datetime(3) NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`payment_id`),
  KEY `idx_fk_customer_id` (`customer_id`),
  KEY `idx_fk_staff_id` (`staff_id`),
  KEY `payment_fk3_idx` (`rental_id`),
  CONSTRAINT `payment_fk1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `payment_fk2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `payment_fk3` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73523 DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `rental`
--

DROP TABLE IF EXISTS `rental`;
CREATE TABLE `rental` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `rental_date` datetime(3) NOT NULL,
  `inventory_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `return_date` datetime(3) DEFAULT NULL,
  `staff_id` int NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`rental_id`),
  UNIQUE KEY `idx_uq` (`rental_date`,`inventory_id`,`customer_id`),
  KEY `idx_fk_customer_id` (`customer_id`),
  KEY `idx_fk_inventory_id` (`inventory_id`),
  KEY `idx_fk_staff_id` (`staff_id`),
  CONSTRAINT `rental_fk1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`),
  CONSTRAINT `rental_fk2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `rental_fk3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=318413 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `address_id` int NOT NULL,
  `picture` longblob,
  `email` varchar(50) DEFAULT NULL,
  `store_id` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(16) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`staff_id`),
  KEY `idx_fk_address_id` (`address_id`),
  KEY `idx_fk_store_id` (`store_id`),
  CONSTRAINT `staff_fk1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`),
  CONSTRAINT `staff_fk2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `manager_staff_id` int NOT NULL,
  `address_id` int NOT NULL,
  `last_update` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `idx_fk_address_id` (`manager_staff_id`),
  KEY `idx_fk_store_address` (`address_id`),
  CONSTRAINT `store_fk1` FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `store_fk2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;