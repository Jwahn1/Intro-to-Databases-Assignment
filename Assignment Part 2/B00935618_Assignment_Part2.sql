CREATE DATABASE IF NOT EXISTS Streetfighter6_character_statistics;
USE Streetfighter6_character_statistics;


-- ---------------------------------------------------------------------------
-- ------------------------- CREATE TABLE PART 2 -------------------------
-- ---------------------------------------------------------------------------


DROP TABLE IF EXISTS character_matchups;
DROP TABLE IF EXISTS character_popularity;
DROP TABLE  IF EXISTS move_list;
DROP TABLE IF EXISTS tier_placement;
DROP TABLE IF EXISTS character_stats; -- PARENT TABLE 

CREATE TABLE IF NOT EXISTS character_stats (
    character_name VARCHAR(50),
	character_archetype VARCHAR(50),
	character_forwardSpeed FLOAT,
	character_backwardSpeed FLOAT,
	character_dashForwardSpeed INT,
	character_dashBackwardSpeed INT,
	character_health INT,
	character_preJumpFrames INT, 
    PRIMARY KEY(character_name)
);



CREATE TABLE IF NOT EXISTS tier_placement (
    character_name VARCHAR(50),
    tier_placement INT,
    PRIMARY KEY(character_name),
    FOREIGN KEY (character_name) REFERENCES character_stats(character_name)
);


CREATE TABLE IF NOT EXISTS move_list (
	character_name VARCHAR(50),
	move_name VARCHAR(50),
    move_buttonCombo VARCHAR(15),
    move_startupFrames INT,
    move_activeFrames INT,
    move_recoveryFrames INT,
    move_onHitAdvantage VARCHAR(15),
    move_onBlockAdvantage VARCHAR(15),
    move_totalFrames INT,
    move_rawDamage INT,
    move_heightHit VARCHAR(15),
    move_crossup VARCHAR (3),
    PRIMARY KEY(character_name,move_name),
    FOREIGN KEY (character_name) REFERENCES character_stats(character_name)
);

CREATE TABLE IF NOT EXISTS character_popularity (
    character_name VARCHAR(50),
    number_of_players INT,
    highest_LP_achieved INT,
    top_player_name VARCHAR(50),
    PRIMARY KEY(character_name),
    FOREIGN KEY (character_name) REFERENCES character_stats(character_name)
);

CREATE TABLE IF NOT EXISTS   character_matchups (
    character_name VARCHAR(50),
    character_matchup VARCHAR(100),
    matchup_score FLOAT, # a vs b , matchup score in favour of character a
    PRIMARY KEY(character_name,character_matchup),
    FOREIGN KEY (character_name) REFERENCES character_stats(character_name)
);


    
INSERT INTO character_stats
	VALUES
    ("RYU","SHOTO",4.7,3.2,19,23,10000,4),
    ("CAMMY","RUSHDOWN",5.05,3.7,18,23,10000,4),
    ("KEN","SHOTO",4.7,3.2,19,23,10000,4),
    ("JP","ZONER",3.7,2.5,22,23,10000,4),
    ("KIMBERLY","RUSHDOWN",5.61,3.66,18,23,10000,4);
    
INSERT INTO tier_placement
	VALUES("RYU",16);
   
    
INSERT INTO move_list
	VALUES("RYU","standing light punch","LP",4,3,7,"+4","-1",13,300,"high","no"),
    ("RYU","crouching light punch","2+LP",4,2,9,"+4","-1",14,300,"high","no");
  
INSERT INTO character_popularity
	VALUES("RYU",199345,259659,"Paladin"),
     ("CAMMY",198014,343084,"Hurricane"),
    ("KEN",291687,255553,"_ts_"),
    ("JP",98530,327886,"Juicyjoe2000"),
    ("KIMBERLY",81535,201982,"Jaccy");
    
INSERT INTO character_matchups
	VALUES
    ("RYU","CAMMY",4.6),
    ("RYU","KEN",4.4),
    ("RYU","JP",3.9),
    ("RYU","KIMBERLY",4.8);
    
    
-- -----------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------
-- PART 3  QUERIES
SELECT * FROM character_stats;
SELECT * FROM move_list;
SELECT * FROM character_popularity;
SELECT * FROM tier_placement;
SELECT * FROM character_matchups;

SELECT character_name AS Rushdown_charcters
	FROM character_stats -- gives us the names of the characters that fit the "RUSHDOWN" archetype 
	WHERE character_archetype IN ("RUSHDOWN");
    
SELECT * -- shows what each characters tier placement is alongside their stats
	FROM character_stats stats
	NATURAL JOIN tier_placement tier;

SELECT character_name,ROUND(AVG(matchup_score),2)  AS average_matchup_score 
	FROM character_matchups -- groups all the matchups for each character and gives the average matchup score they have agaisnt the whole roster 
	GROUP BY character_name;

SELECT character_name, ROUND(AVG(move_rawDamage),2) FROM move_list -- gets the average damage made by all the attacks of one character 
GROUP BY character_name;


