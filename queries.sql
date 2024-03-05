-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
INSERT INTO "stadiums" ("name","capacity","city")
VALUES ("mohamed V",45000,"casablanca"),("molay abd allah",60000,"rabat");

--insert some zones
INSERT INTO "zones" ("name","capacity","stadium_id","price")
VALUES
("1",5000,1,50),("2",5000,1,50),("3",5000,1,50),
("4",7000,1,30),("5",13000,1,30),
("6",5000,1,30),("7",5000,1,30);

-- insert some matches
INSERT INTO "matches" ("home_team","away_team","match_date","stadium_id","type")
VALUES ("RCA","WAC","2024-03-01",1,"botola pro matche"),
("RCA","FAR","2024-03-06",1,"botola pro matche"),
("RCA","RSB","2024-03-10",1,"botola pro matche");

-- inserting dummy data
INSERT INTO "tickets" ("zone_id","match_id","stadium_id","price")
VALUES (5,1,1,30),(5,1,1,30),(5,1,1,30),(5,1,1,30),(5,1,1,30),(5,1,1,30),(5,1,1,30);

-- count ticket of a match
SELECT COUNT("id") AS "tickets sold","zone_id" FROM "tickets" WHERE "match_id" = 2 GROUP BY "zone_id";

-- count ticket where RCA was the home team
SELECT COUNT("id") AS "tickets sold","zone_id" FROM "tickets"
WHERE "match_id" IN (SELECT "id" FROM "matches" WHERE "home_team" = "RCA") GROUP BY "zone_id";

-- SELECT available matches
SELECT "matches"."id", "home_team","away_team","match_date","stadiums"."name" FROM "matches"
                 JOIN "stadiums" ON "stadiums"."id" = "matches"."stadium_id"
                 WHERE "ended" = 0 ORDER BY "match_date" ;

-- select zone_id and stadium_id and the number of tickets sold from every zone wher match_id = 1
SELECT "zones".name"","zones"."stadium_id","capacity" , COUNT("tickets"."id") AS 'tickets sold' FROM "zones"
JOIN "tickets" ON "tickets"."zone_id" = "zones"."id"
WHERE "match_id" = 1 GROUP BY  "tickets"."zone_id" ;
