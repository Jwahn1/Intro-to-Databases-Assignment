USE Streetfighter6_character_statistics;


SELECT * FROM character_stats;
SELECT * FROM move_list;
SELECT * FROM character_popularity;
SELECT * FROM tier_placement;
SELECT * FROM character_matchups;

-- query 1

SELECT AVG(number_of_players) 
	FROM character_popularity
	WHERE character_name LIKE "B%"; 

-- query 2
SELECT *
	FROM character_stats
	NATURAL JOIN character_popularity;

-- query 3
SELECT stats.character_archetype, AVG(pop.number_of_players)
	FROM character_popularity pop, character_stats stats
	WHERE pop.character_name = stats.character_name
	GROUP BY stats.character_archetype; 
    
-- query 4
SELECT ROUND(AVG(number_of_players)) AS average_players_in_top_3_playstyles
FROM (SELECT stats.character_archetype, AVG(pop.number_of_players) AS number_of_players
	FROM character_popularity pop, character_stats stats
	WHERE pop.character_name = stats.character_name
	GROUP BY stats.character_archetype ORDER BY AVG(pop.number_of_players) LIMIT 3) AS temp;

    

