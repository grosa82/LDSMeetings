CREATE TABLE `lds_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `scheduled_by` datetime NOT NULL,
  `place` varchar(45) NOT NULL,
  `obs` varchar(200) DEFAULT NULL,
  `unit_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activity_unit_idx` (`unit_id`),
  CONSTRAINT `fk_activity_unit` FOREIGN KEY (`unit_id`) REFERENCES `lds_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_admin_user_idx` (`user_id`),
  CONSTRAINT `fk_admin_user` FOREIGN KEY (`user_id`) REFERENCES `lds_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lds_calling` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `organization_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_calling_organization_idx` (`organization_id`),
  CONSTRAINT `fk_calling_organization` FOREIGN KEY (`organization_id`) REFERENCES `lds_organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_calling_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `calling_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `other` varchar(45) DEFAULT NULL,
  `calling_date` date NOT NULL,
  `calling_flag` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_calling_member_member_idx` (`member_id`),
  KEY `fk_calling_member_calling_idx` (`calling_id`),
  CONSTRAINT `fk_calling_member_calling` FOREIGN KEY (`calling_id`) REFERENCES `lds_calling` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_calling_member_member` FOREIGN KEY (`member_id`) REFERENCES `lds_member` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_family` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `father_id` int(11) DEFAULT NULL,
  `mother_id` int(11) DEFAULT NULL,
  `child_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_family_father_idx` (`father_id`),
  KEY `fk_family_mother_idx` (`mother_id`),
  KEY `fk_family_child_idx` (`child_id`),
  CONSTRAINT `fk_family_child` FOREIGN KEY (`child_id`) REFERENCES `lds_member` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_family_father` FOREIGN KEY (`father_id`) REFERENCES `lds_member` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_family_mother` FOREIGN KEY (`mother_id`) REFERENCES `lds_member` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lds_frequency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `created_by` date NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_frequency` (`member_id`,`created_by`,`type_id`),
  KEY `fk_frequency_member_idx` (`member_id`),
  KEY `fk_frequency_type_idx` (`type_id`),
  CONSTRAINT `fk_frequency_member` FOREIGN KEY (`member_id`) REFERENCES `lds_member` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_frequency_type` FOREIGN KEY (`type_id`) REFERENCES `lds_frequency_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25561 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_frequency_type` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lds_hymn` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lds_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `birthdate` date NOT NULL,
  `unit_id` int(11) NOT NULL,
  `created_by` datetime NOT NULL,
  `member_record` varchar(45) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `restricted` int(11) NOT NULL DEFAULT '0',
  `gender` varchar(1) NOT NULL,
  `unit_member` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_member_unit_idx` (`unit_id`),
  CONSTRAINT `fk_member_unit` FOREIGN KEY (`unit_id`) REFERENCES `lds_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3106 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_priesthood` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(100) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_priesthood_member_idx` (`member_id`),
  CONSTRAINT `fk_priesthood_member` FOREIGN KEY (`member_id`) REFERENCES `lds_member` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=643 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_sacramental` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `conducted_by` int(11) DEFAULT NULL,
  `presided_by` int(11) DEFAULT NULL,
  `recognitions` mediumtext,
  `opening_hymn` int(11) DEFAULT NULL,
  `first_prayer` int(11) DEFAULT NULL,
  `stake` mediumtext,
  `stake_flag` int(11) DEFAULT '0',
  `ward` mediumtext,
  `ward_flag` int(11) DEFAULT '0',
  `sacramental_hymn` int(11) DEFAULT NULL,
  `speaker1` int(11) DEFAULT '0',
  `speaker2` int(11) DEFAULT '0',
  `speaker3` int(11) DEFAULT '0',
  `speaker4` int(11) DEFAULT '0',
  `speaker5` int(11) DEFAULT '0',
  `speaker1_theme` varchar(100) DEFAULT NULL,
  `speaker2_theme` varchar(100) DEFAULT NULL,
  `speaker3_theme` varchar(100) DEFAULT NULL,
  `speaker4_theme` varchar(100) DEFAULT NULL,
  `speaker5_theme` varchar(100) DEFAULT NULL,
  `intermediate_hymn` int(11) DEFAULT NULL,
  `pianist_by` int(11) DEFAULT NULL,
  `hymn_conducted_by` int(11) DEFAULT NULL,
  `other_subjects` mediumtext,
  `last_hymn` int(11) DEFAULT NULL,
  `last_prayer` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_sacramental` (`date`,`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `created_by` datetime NOT NULL,
  `unit_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_topic_unit_idx` (`unit_id`),
  CONSTRAINT `fk_topic_unit` FOREIGN KEY (`unit_id`) REFERENCES `lds_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lds_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_by` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unit_user_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(256) NOT NULL,
  `created_by` datetime NOT NULL,
  `profile` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

CREATE TABLE `lds_user_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_unit_user_idx` (`user_id`),
  KEY `fk_user_unit_unit_idx` (`unit_id`),
  CONSTRAINT `fk_user_unit_unit` FOREIGN KEY (`unit_id`) REFERENCES `lds_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_unit_user` FOREIGN KEY (`user_id`) REFERENCES `lds_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
