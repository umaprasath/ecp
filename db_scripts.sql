CREATE TABLE `ecp_ad_cross_sell` (
  `ad_id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_name` varchar(45) DEFAULT NULL,
  `ad_category` varchar(45) DEFAULT NULL,
  `ecp_route_route_id` int(11) NOT NULL,
  `ad_promotion_detail` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ad_id`),
  KEY `fk_ecp_ad_cross_sell_ecp_route1_idx` (`ecp_route_route_id`),
  CONSTRAINT `fk_ecp_ad_cross_sell_ecp_route1` FOREIGN KEY (`ecp_route_route_id`) REFERENCES `ecp_route` (`route_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB 


delimiter $$


CREATE TABLE `ecp_customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `door_no` varchar(45) DEFAULT NULL,
  `customer_name` varchar(45) DEFAULT NULL,
  `suburb` varchar(45) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `route_id` varchar(45) DEFAULT NULL,
  `contact_no` varchar(45) DEFAULT NULL,
  `ecp_user_customer_login_email` varchar(50) NOT NULL,
  `ecp_customer_company_customer_company_id` int(11) NOT NULL,
  `rating` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`ecp_customer_company_customer_company_id`),
  KEY `fk_ecp_customer_ecp_user1_idx` (`ecp_user_customer_login_email`),
  KEY `fk_ecp_customer_ecp_customer_company1_idx` (`ecp_customer_company_customer_company_id`),
  CONSTRAINT `fk_ecp_customer_ecp_customer_company1` FOREIGN KEY (`ecp_customer_company_customer_company_id`) REFERENCES `ecp_customer_company` (`customer_company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ecp_customer_ecp_user1` FOREIGN KEY (`ecp_user_customer_login_email`) REFERENCES `ecp_user` (`ecp_email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 


delimiter $$

CREATE TABLE `ecp_customer_address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `street_no` varchar(45) DEFAULT NULL,
  `door_no` varchar(45) DEFAULT NULL,
  `suburb` varchar(45) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `ecp_customer_customer_id` int(11) NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `fk_ecp_address_ecp_customer1_idx` (`ecp_customer_customer_id`),
  CONSTRAINT `fk_ecp_address_ecp_customer1` FOREIGN KEY (`ecp_customer_customer_id`) REFERENCES `ecp_customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB 


delimiter $$

CREATE TABLE `ecp_customer_company` (
  `customer_company_id` int(11) NOT NULL,
  `ecp_customer_companycol` varchar(45) DEFAULT NULL,
  `ecp_company_company_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_company_id`),
  KEY `fk_ecp_customer_company_ecp_company1_idx` (`ecp_company_company_id`),
  CONSTRAINT `fk_ecp_customer_company_ecp_company1` FOREIGN KEY (`ecp_company_company_id`) REFERENCES `ecp_company` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB 


delimiter $$

CREATE TABLE `ecp_customer_route` (
  `ecp_customer_customer_id` int(11) NOT NULL,
  `ecp_route_route_id` int(11) NOT NULL,
  `isDefault` char(1) DEFAULT NULL,
  `current_geo_location` varchar(45) DEFAULT NULL,
  KEY `fk_table1_ecp_customer1_idx` (`ecp_customer_customer_id`),
  KEY `fk_table1_ecp_route1_idx` (`ecp_route_route_id`),
  CONSTRAINT `fk_table1_ecp_customer1` FOREIGN KEY (`ecp_customer_customer_id`) REFERENCES `ecp_customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_ecp_route1` FOREIGN KEY (`ecp_route_route_id`) REFERENCES `ecp_route` (`route_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB 


delimiter $$

CREATE TABLE `ecp_customer_social_media` (
  `ecp_customer_customer_id` int(11) NOT NULL,
  `ecp_social_media_social_media_id` int(11) NOT NULL,
  `is_allow` char(1) DEFAULT NULL,
  KEY `fk_ecp_customer_social_media_ecp_customer1_idx` (`ecp_customer_customer_id`),
  KEY `fk_ecp_customer_social_media_ecp_social_media1_idx` (`ecp_social_media_social_media_id`),
  CONSTRAINT `fk_ecp_customer_social_media_ecp_customer1` FOREIGN KEY (`ecp_customer_customer_id`) REFERENCES `ecp_customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ecp_customer_social_media_ecp_social_media1` FOREIGN KEY (`ecp_social_media_social_media_id`) REFERENCES `ecp_social_media` (`social_media_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB 


delimiter $$

CREATE TABLE `ecp_pool_ride` (
  `DRIVER_EMAIL` varchar(45) NOT NULL,
  `RIDER_EMAIL` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`DRIVER_EMAIL`),
  UNIQUE KEY `RIDER_EMAIL_UNIQUE` (`RIDER_EMAIL`)
) ENGINE=InnoDB 


delimiter $$

CREATE TABLE `ecp_route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(45) DEFAULT NULL,
  `to` varchar(45) DEFAULT NULL,
  `via_route` varchar(20000) DEFAULT NULL,
  `from_geo_location` varchar(100) DEFAULT NULL,
  `to_geo_location` varchar(100) DEFAULT NULL,
  `from_start_time` varchar(45) DEFAULT NULL,
  `to_start_time` varchar(45) DEFAULT NULL,
  `from_lat` float DEFAULT NULL,
  `from_lng` float DEFAULT NULL,
  `to_lat` float DEFAULT NULL,
  `to_lng` float DEFAULT NULL,
  `customer_email` varchar(45) NOT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28


delimiter $$

CREATE TABLE `ecp_social_media` (
  `social_media_id` int(11) NOT NULL AUTO_INCREMENT,
  `social_media_name` varchar(45) DEFAULT NULL,
  `social_media_email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`social_media_id`)
) ENGINE=InnoDB 



