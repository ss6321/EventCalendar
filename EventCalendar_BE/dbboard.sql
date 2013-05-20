CREATE DATABASE dbboard;
use dbboard;

CREATE TABLE `calendar` (
 `no` int(4) NOT NULL AUTO_INCREMENT,
 `year` varchar(10) DEFAULT NULL,
 `month` varchar(10) DEFAULT NULL,
 `day` varchar(10) DEFAULT NULL,
 `title` varchar(40) DEFAULT NULL,
 `s_time` varchar(10) DEFAULT NULL,
 `e_time` varchar(10) DEFAULT NULL,
 `position` varchar(40) DEFAULT NULL,
 `content` varchar(16) DEFAULT NULL,
 PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE `attendance` (
  `index` double NOT NULL AUTO_INCREMENT,
  `event_id` varchar(225) NOT NULL,
  `member_id` varchar(225) NOT NULL,
  `status` varchar(225) NOT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE `click_log` (
  `index` double NOT NULL AUTO_INCREMENT,
  `event_id` varchar(225) NOT NULL,
  `member_id` varchar(225) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE `tblmember` (
  `id` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `level` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `tblmember` (`id`, `pass`, `name`, `phone`, `email`, `level`) VALUES
('soo', '1234', 'soobok', '9173108006', 'ss6321@nyu.edu', 1);