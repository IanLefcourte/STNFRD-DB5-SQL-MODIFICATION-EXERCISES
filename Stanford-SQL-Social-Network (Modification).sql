-- DROP TABLE IF ALREADY EXISTS
DROP TABLE if exists Highschooler;
DROP TABLE if exists Friend;
DROP TABLE if exists Likes;

-- CREATE TABLE SCHEMA
CREATE TABLE Highschooler(ID int, name text, grade int);
CREATE TABLE Friend(ID1 int, ID2 int);
CREATE TABLE Likes(ID1 int, ID2 int);

-- INSERT SPECIFIC DATA INTO TABLES
INSERT INTO Highschooler values (1510, 'Jordan', 9);
INSERT INTO Highschooler values (1689, 'Gabriel', 9);
INSERT INTO Highschooler values (1381, 'Tiffany', 9);
INSERT INTO Highschooler values (1709, 'Cassandra', 9);
INSERT INTO Highschooler values (1101, 'Haley', 10);
INSERT INTO Highschooler values (1782, 'Andrew', 10);
INSERT INTO Highschooler values (1468, 'Kris', 10);
INSERT INTO Highschooler values (1641, 'Brittany', 10);
INSERT INTO Highschooler values (1247, 'Alexis', 11);
INSERT INTO Highschooler values (1316, 'Austin', 11);
INSERT INTO Highschooler values (1911, 'Gabriel', 11);
INSERT INTO Highschooler values (1501, 'Jessica', 11);
INSERT INTO Highschooler values (1304, 'Jordan', 12);
INSERT INTO Highschooler values (1025, 'John', 12);
INSERT INTO Highschooler values (1934, 'Kyle', 12);
INSERT INTO Highschooler values (1661, 'Logan', 12);

INSERT INTO Friend values (1510, 1381);
INSERT INTO Friend values (1510, 1689);
INSERT INTO Friend values (1689, 1709);
INSERT INTO Friend values (1381, 1247);
INSERT INTO Friend values (1709, 1247);
INSERT INTO Friend values (1689, 1782);
INSERT INTO Friend values (1782, 1468);
INSERT INTO Friend values (1782, 1316);
INSERT INTO Friend values (1782, 1304);
INSERT INTO Friend values (1468, 1101);
INSERT INTO Friend values (1468, 1641);
INSERT INTO Friend values (1101, 1641);
INSERT INTO Friend values (1247, 1911);
INSERT INTO Friend values (1247, 1501);
INSERT INTO Friend values (1911, 1501);
INSERT INTO Friend values (1501, 1934);
INSERT INTO Friend values (1316, 1934);
INSERT INTO Friend values (1934, 1304);
INSERT INTO Friend values (1304, 1661);
INSERT INTO Friend values (1661, 1025);
INSERT INTO Friend select ID2, ID1 from Friend;

INSERT INTO Likes values(1689, 1709);
INSERT INTO Likes values(1709, 1689);
INSERT INTO Likes values(1782, 1709);
INSERT INTO Likes values(1911, 1247);
INSERT INTO Likes values(1247, 1468);
INSERT INTO Likes values(1641, 1468);
INSERT INTO Likes values(1316, 1304);
INSERT INTO Likes values(1501, 1934);
INSERT INTO Likes values(1934, 1501);
INSERT INTO Likes values(1025, 1101);

-- SQL Social Network Data Modification Exercises

-- Q1 It's time for the seniors to graduate. Remove all 12th graders from Highschooler.  
DELETE FROM highschooler
WHERE grade = 12;

-- Q2 If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.   
DELETE FROM likes
WHERE id2 IN (SELECT id2
              FROM friend
              WHERE friend.id1 = likes.id1)
AND
      id2 NOT IN (SELECT L1.id1
                  FROM likes L1
                  WHERE L1.id2 = likes.id1);

-- Q3 For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. 
INSERT INTO friend
SELECT DISTINCT f1.id1, f2.id2
FROM friend f1, friend f2
WHERE
  f1.id2 = f2.id1 AND
  f1.id1 <> f2.id2 AND
  f1.id1 NOT IN (SELECT f3.id1
                 FROM friend f3
                 WHERE f3.id2 = f2.id2);