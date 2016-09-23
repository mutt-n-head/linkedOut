DROP TABLE IF EXISTS userauthenticate;

CREATE TABLE IF NOT EXISTS userauthenticate (
  userid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(25) NOT NULL,
  password VARCHAR(50) NULL DEFAULT NULL,
  approved INTEGEREGER(1) NULL DEFAULT 0,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  lastlogin DATETIME NULL DEFAULT NULL,
  salt VARCHAR(50) NULL DEFAULT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS uc_username ON userauthenticate (username ASC);

DROP TABLE IF EXISTS certifications;

CREATE TABLE IF NOT EXISTS certifications (
  userid INTEGER(11) NOT NULL,
  cname VARCHAR(50) NULL DEFAULT NULL,
  cauthority VARCHAR(50) NULL DEFAULT NULL,
  clicensenumber VARCHAR(50) NULL DEFAULT NULL,
  curl VARCHAR(50) NULL DEFAULT NULL,
  cstartdate DATE NULL DEFAULT NULL,
  cenddate DATE NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT certifications_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON certifications (userid ASC);

DROP TABLE IF EXISTS posts ;

CREATE TABLE IF NOT EXISTS posts (
  userid INTEGER(11) NOT NULL,
  postid INTEGER(11) NOT NULL,
  postheadline VARCHAR(25) NULL DEFAULT NULL,
  postbody VARCHAR(1000) NULL DEFAULT NULL,
  likes INTEGER(11) NULL DEFAULT '0',
  comments INTEGER(11) NULL DEFAULT '0',
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  PRIMARY KEY (postid),
  CONSTRAINT posts_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON posts (userid ASC);

DROP TABLE IF EXISTS comments ;

CREATE TABLE IF NOT EXISTS comments (
  postid INTEGER(11) NOT NULL,
  commentid INTEGER(11) NOT NULL,
  userid INTEGER(11) NOT NULL,
  commentbody VARCHAR(250) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT comments_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid),
  CONSTRAINT comments_ibfk_2
    FOREIGN KEY (postid)
    REFERENCES posts (postid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON comments (userid ASC);

CREATE INDEX IF NOT EXISTS fk_postid ON comments (postid ASC);

DROP TABLE IF EXISTS education ;

CREATE TABLE IF NOT EXISTS education (
  educationid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  userid INTEGER(11) NOT NULL,
  school VARCHAR(50) NULL DEFAULT NULL,
  startdate DATE NULL DEFAULT NULL,
  enddate DATE NULL DEFAULT NULL,
  currentlydoing INTEGER(1) NULL DEFAULT '0',
  degree VARCHAR(50) NULL DEFAULT NULL,
  field VARCHAR(50) NULL DEFAULT NULL,
  grade DECIMAL(4,1) NULL DEFAULT NULL,
  activities VARCHAR(250) NULL DEFAULT NULL,
  description VARCHAR(1000) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT education_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid));

CREATE INDEX IF NOT EXISTS education_ibfk_1 ON education (userid ASC);

DROP TABLE IF EXISTS courses ;

CREATE TABLE IF NOT EXISTS courses (
  userid INTEGER NOT NULL,
  educationid INTEGER NOT NULL,
  coursename VARCHAR(50) NULL DEFAULT NULL,
  courseid VARCHAR(15) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT courses_ibfk_1
    FOREIGN KEY (userid , educationid)
    REFERENCES education (userid , educationid)
);


CREATE INDEX IF NOT EXISTS fk_educationid ON courses (userid ASC, educationid ASC);

DROP TABLE IF EXISTS educationdetails ;

CREATE TABLE IF NOT EXISTS educationdetails (
  userid INTEGER(11) NOT NULL,
  educationid INTEGER(11) NOT NULL,
  detailslink VARCHAR(50) NULL DEFAULT NULL,
  fileorurl BLOB,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT educationdetails_ibfk_1
  FOREIGN KEY (userid , educationid)
  REFERENCES education (userid , educationid)
);

CREATE INDEX IF NOT EXISTS fk_educationid ON educationdetails (userid ASC, educationid ASC);

DROP TABLE IF EXISTS skills ;

CREATE TABLE IF NOT EXISTS skills (
  userid INTEGER(11) NOT NULL,
  skillid INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
  skillname VARCHAR(50) NULL DEFAULT NULL,
  endorsementcount INTEGER(11) NULL DEFAULT '0',
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT skills_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON skills (userid ASC);

DROP TABLE IF EXISTS endorsements ;

CREATE TABLE IF NOT EXISTS endorsements (
  userid INTEGER(11) NOT NULL,
  skillid INTEGER(11) NOT NULL,
  euserid INTEGER(11) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT endorsements_ibfk_1
    FOREIGN KEY (euserid)
    REFERENCES userauthenticate (userid),
  CONSTRAINT endorsements_ibfk_2
    FOREIGN KEY (userid , skillid)
    REFERENCES skills (userid , skillid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON endorsements (euserid ASC);

CREATE INDEX IF NOT EXISTS fk_skill ON endorsements (userid ASC, skillid ASC);

DROP TABLE IF EXISTS experience ;

CREATE TABLE IF NOT EXISTS experience (
  userid INTEGER(11) NOT NULL,
  experienceid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  companyname VARCHAR(100) NULL DEFAULT NULL,
  title VARCHAR(50) NULL DEFAULT NULL,
  location VARCHAR(50) NULL DEFAULT NULL,
  startdate DATE NULL DEFAULT NULL,
  enddate DATE NULL DEFAULT NULL,
  currentlyworking INTEGER(1) NULL DEFAULT '0',
  description VARCHAR(1000) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT experience_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS experience_ibfk_1 ON experience (userid ASC);

DROP TABLE IF EXISTS experiencedetails ;

CREATE TABLE IF NOT EXISTS experiencedetails (
  userid INT(11) NOT NULL,
  experienceid INT(11) NOT NULL,
  detailslink VARCHAR(50) NULL DEFAULT NULL,
  fileorurl BLOB,
  modifydate DATE NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  CONSTRAINT experiencedetails_ibfk_1
    FOREIGN KEY (userid , experienceid)
    REFERENCES experience (userid , experienceid)
);

CREATE INDEX IF NOT EXISTS fk_experience ON experiencedetails (userid ASC, experienceid ASC);

DROP TABLE IF EXISTS following ;

CREATE TABLE IF NOT EXISTS following (
  userid INTEGER(11) NOT NULL,
  category TEXT CHECK(category IN ('company','school') ) NULL DEFAULT NULL,
  organisationid INTEGER(11) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT following_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid),
  CONSTRAINT following_ibfk_2
    FOREIGN KEY (organisationid)
    REFERENCES userauthenticate (userid)
);


CREATE INDEX IF NOT EXISTS fk_userid ON following (userid ASC);

CREATE INDEX IF NOT EXISTS fk_organisationid ON following (organisationid ASC);

DROP TABLE IF EXISTS honorsandawards ;

CREATE TABLE IF NOT EXISTS honorsandawards (
  userid INTEGER(11) NOT NULL,
  title VARCHAR(50) NULL DEFAULT NULL,
  occupation VARCHAR(50) NULL DEFAULT NULL,
  issuer VARCHAR(50) NULL DEFAULT NULL,
  dateofissue DATE NULL DEFAULT NULL,
  description VARCHAR(250) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT honorsandawards_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON honorsandawards (userid ASC);


-- -----------------------------------------------------
-- Table languages
-- -----------------------------------------------------
DROP TABLE IF EXISTS languages ;

CREATE TABLE IF NOT EXISTS languages (
  userid INTEGER(11) NOT NULL,
  languages VARCHAR(25) NULL DEFAULT NULL,
  proficiency VARCHAR(25) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT languages_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON languages (userid ASC);


-- -----------------------------------------------------
-- Table likes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS likes (
  postid INTEGER(11) NOT NULL,
  userid INTEGER(11) NOT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT likes_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid),
  CONSTRAINT likes_ibfk_2
    FOREIGN KEY (postid)
    REFERENCES posts (postid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON CMPE_282.likes (userid ASC);

CREATE INDEX IF NOT EXISTS fk_postid ON CMPE_282.likes (postid ASC);


-- -----------------------------------------------------
-- Table organisation
-- -----------------------------------------------------
DROP TABLE IF EXISTS organisation ;

CREATE TABLE IF NOT EXISTS organisation (
  userid INTEGER(11) NULL DEFAULT NULL,
  organisationname VARCHAR(50) NULL DEFAULT NULL,
  organisationtype TEXT CHECK(organisationtype IN ('company','school') ) NULL DEFAULT NULL,
  photo VARCHAR(50) NULL DEFAULT NULL,
  following INTEGER(11) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT organisation_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON organisation (userid ASC);


-- -----------------------------------------------------
-- Table projects
-- -----------------------------------------------------
DROP TABLE IF EXISTS projects ;

CREATE TABLE IF NOT EXISTS projects (
  userid INTEGER(11) NOT NULL,
  projectid INTEGER(11) NOT NULL DEFAULT '0',
  pname VARCHAR(50) NULL DEFAULT NULL,
  poccupation VARCHAR(50) NULL DEFAULT NULL,
  startdate DATE NULL DEFAULT NULL,
  enddate DATE NULL DEFAULT NULL,
  currentlyworking INTEGER(1) NULL DEFAULT '0',
  projecturl VARCHAR(50) NULL DEFAULT NULL,
  description VARCHAR(1000) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  PRIMARY KEY (userid, projectid),
  CONSTRAINT projects_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);


-- -----------------------------------------------------
-- Table projectmembers
-- -----------------------------------------------------
DROP TABLE IF EXISTS projectmembers ;

CREATE TABLE IF NOT EXISTS projectmembers (
  userid INTEGER(11) NOT NULL,
  projectid INTEGER(11) NOT NULL,
  muserid INTEGER(11) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT projectmembers_ibfk_1
    FOREIGN KEY (muserid)
    REFERENCES userauthenticate (userid),
  CONSTRAINT projectmembers_ibfk_2
    FOREIGN KEY (userid , projectid)
    REFERENCES projects (userid , projectid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON projectmembers (muserid ASC);

CREATE INDEX IF NOT EXISTS fk_projectid ON projectmembers (userid ASC, projectid ASC);


-- -----------------------------------------------------
-- Table summary
-- -----------------------------------------------------
DROP TABLE IF EXISTS summary ;

CREATE TABLE IF NOT EXISTS summary (
  userid INTEGER(11) NOT NULL,
  summarydesc VARCHAR(1000) NULL DEFAULT NULL,
  document VARCHAR(50) NULL DEFAULT NULL,
  photo VARCHAR(50) NULL DEFAULT NULL,
  link VARCHAR(50) NULL DEFAULT NULL,
  video VARCHAR(50) NULL DEFAULT NULL,
  presentation VARCHAR(50) NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  modifydate DATE NULL DEFAULT NULL,
  CONSTRAINT summary_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

CREATE INDEX IF NOT EXISTS fk_userid ON summary (userid ASC);


-- -----------------------------------------------------
-- Table userdetails
-- -----------------------------------------------------
DROP TABLE IF EXISTS userdetails ;

CREATE TABLE IF NOT EXISTS userdetails (
  userid INTEGER(11) NOT NULL,
  firstname VARCHAR(25) NULL DEFAULT NULL,
  lastname VARCHAR(25) NULL DEFAULT NULL,
  email VARCHAR(40) NULL DEFAULT NULL,
  photo VARCHAR(50) NULL DEFAULT NULL,
  headline VARCHAR(100) NULL DEFAULT NULL,
  country VARCHAR(50) NULL DEFAULT NULL,
  state VARCHAR(50) NULL DEFAULT NULL,
  city VARCHAR(50) NULL DEFAULT NULL,
  industry VARCHAR(50) NULL DEFAULT NULL,
  phone VARCHAR(50) NULL DEFAULT NULL,
  address VARCHAR(50) NULL DEFAULT NULL,
  twitter_handle VARCHAR(50) NULL DEFAULT NULL,
  websites VARCHAR(50) NULL DEFAULT NULL,
  summary INTEGER(1) NULL DEFAULT '0',
  certifications INTEGER(1) NULL DEFAULT '0',
  honorsandawards INTEGER(1) NULL DEFAULT '0',
  experience INTEGER(1) NULL DEFAULT '0',
  skillsandendorsements INTEGER(1) NULL DEFAULT '0',
  projects INTEGER(1) NULL DEFAULT '0',
  languages INTEGER(1) NULL DEFAULT '0',
  education INTEGER(1) NULL DEFAULT '0',
  additionalinfo INTEGER(1) NULL DEFAULT '0',
  volunteer INTEGER(1) NULL DEFAULT '0',
  courses INTEGER(1) NULL DEFAULT '0',
  following INTEGER(1) NULL DEFAULT '0',
  modifydate DATE NULL DEFAULT NULL,
  creationdate DATE NULL DEFAULT NULL,
  PRIMARY KEY (userid),
  CONSTRAINT userdetails_ibfk_1
    FOREIGN KEY (userid)
    REFERENCES userauthenticate (userid)
);

DROP TRIGGER IF EXISTS comment_count $$
USE CMPE_282$$
CREATE
DEFINER=root@localhost
TRIGGER comment_count
AFTER INSERT ON comments
FOR EACH ROW
update posts set comments=comments+1 where postid=new.postid$$


-- For an example of an INSTEAD OF trigger, consider the following schema: 

-- CREATE TABLE customer(
--   cust_id INTEGER PRIMARY KEY,
--   cust_name TEXT,
--   cust_addr TEXT
-- );
-- CREATE VIEW customer_address AS
--    SELECT cust_id, cust_addr FROM customer;
-- CREATE TRIGGER cust_addr_chng
-- INSTEAD OF UPDATE OF cust_addr ON customer_address
-- BEGIN
--   UPDATE customer SET cust_addr=NEW.cust_addr
--    WHERE cust_id=NEW.cust_id;
-- END;


-- USE CMPE_282;

-- DELIMITER $$

-- USE CMPE_282$$
-- DROP TRIGGER IF EXISTS CMPE_282.comment_count $$
-- USE CMPE_282$$
-- CREATE
-- DEFINER=root@localhost
-- TRIGGER CMPE_282.comment_count
-- AFTER INSERT ON CMPE_282.comments
-- FOR EACH ROW
-- update posts set comments=comments+1 where postid=new.postid$$


-- USE CMPE_282$$
-- DROP TRIGGER IF EXISTS CMPE_282.like_count $$
-- USE CMPE_282$$
-- CREATE
-- DEFINER=root@localhost
-- TRIGGER CMPE_282.like_count
-- AFTER INSERT ON CMPE_282.likes
-- FOR EACH ROW
-- update posts set likes=likes+1 where postid=new.postid$$


-- DELIMITER ;

-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ALTER TABLE userdetails add column dob varchar(25);
-- ALTER TABLE userdetails modify column summary varchar(250);
-- alter table userauthenticate add column usertype varchar(3) default 'usr';
-- alter table organisation add column email varchar(40);

CREATE TABLE jobapplications (
  applicationid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  userid varchar(45) NOT NULL,
  jobid varchar(45) NOT NULL,
  status varchar(45) DEFAULT NULL  
) ;