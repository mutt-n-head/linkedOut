INSERT INTO user (username, fullname,password, photoid) values ('User1@fakeemail.com', 'GreggyP', 'User1',1);
INSERT INTO user (username, fullname,password, photoid) values ('User2@fakeemail.com', 'BobbyK', 'User2',2);
INSERT INTO user (username, fullname,password, photoid) values ('User3@fakeemail.com', 'HerbS', 'User3',3);
INSERT INTO user (username, fullname,password, photoid) values ('User4@fakeemail.com', 'JohnnyM', 'User4',4);
INSERT INTO user (username, fullname,password, photoid) values ('User5@fakeemail.com', 'MarcC', 'User5',5);
INSERT INTO user (username, fullname,password, photoid) values ('joe@mail.com', 'Joe Sixpack', 'password',6);
Insert into post (userid, post, photoid) values (1,'I am the man!', 6);
Insert into post (userid, post, photoid) values (2,'Reboot it!!', 7);
Insert into following (followerid, followeeid) values (1, 1);
Insert into following (followerid, followeeid) values (1, 2);
Insert into following (followerid, followeeid) values (2, 2);
Insert into following (followerid, followeeid) values (2, 1);
Insert Into likes (likerid, likeeid, postid) values (2,1,1);
Insert Into likes (likerid, likeeid, postid) values (1,2,2);
Insert Into comment (postid, comment) values (1, 'no Im the man!!');
Insert Into comment (postid, comment) values (2, 'you said it');
Insert Into photo (photoname, mimetype) values ('User1.jpg','Image/Jpeg');
Insert Into photo (photoname, mimetype) values ('User2.jpg','Image/Jpeg');
Insert Into photo (photoname, mimetype) values ('User3.jpg','Image/Jpeg');
Insert Into photo (photoname, mimetype) values ('User4.jpg','Image/Jpeg');
Insert Into photo (photoname, mimetype) values ('User5.jpg','Image/Jpeg');
Insert Into photo (photoname, mimetype) values ('theman.jpg','Image/Jpeg');
Insert Into photo (photoname, mimetype) values ('reboot.jpg','Image/Jpeg');
Insert Into messages (messengerid, messageeid, subject, message) values ('1','2','first subject', 'first message text');
