USE Streetfighter6_character_statistics;

-- procedure will delete  
-- changes the frame data for 1 move from 1 character  
-- the inputs apart from the name of the move and the character are negative or positive (+ or -) 
DELIMITER $$
DROP PROCEDURE IF EXISTS rebalance_move$$
CREATE PROCEDURE rebalance_move (IN current_character VARCHAR(100), IN move_current VARCHAR(100),IN move_startupChange INT,IN move_activeChange INT,IN move_recoveryChange INT,IN move_onHitChange INT,IN move_onBlockChange INT,IN move_rawChange INT)
BEGIN 
	START TRANSACTION;
        UPDATE move_list SET move_startupFrames = move_startupFrames + move_startupChange WHERE character_name = current_character AND move_name = move_current;
        UPDATE move_list SET move_activeFrames = move_activeFrames + move_activeChange WHERE character_name = current_character AND move_name = move_current;
        UPDATE move_list SET move_recoveryFrames = move_recoveryFrames+ move_recoveryChange WHERE character_name = current_character AND move_name = move_current;
        UPDATE move_list SET move_onHitAdvantage = move_onHitAdvantage + move_onHitChange WHERE character_name = current_character AND move_name = move_current;
        UPDATE move_list SET move_onBlockAdvantage = move_onBlockAdvantage + move_onBlockChange WHERE character_name = current_character AND move_name = move_current;
        UPDATE move_list SET move_totalFrames = move_totalFrames + move_startupChange + move_activeChange + move_recoveryChange  WHERE character_name = current_character AND move_name = move_current;
        UPDATE move_list SET move_rawDamage = move_rawDamage + move_rawChange WHERE character_name = current_character AND move_name = move_current;
        SELECT * FROM move_list  WHERE character_name = current_character AND move_name = move_current ;
	COMMIT;
END;
$$

-- put how many frames you want to add or remove to each section of a move 
-- in order its move_startupFrames,move_activeFrames,move_recoveryFrames,move_onHitAdvantage,move_onBlockAdvantage,move_rawDamage
-- the move_totalFrames is changed inside the procedure based on how many frames are changed in the entire move
CALL rebalance_move("RYU","fireball",10,32,100,0,0,32131);



-- procedure will delete  all data in the database for the character_name inputed
DELIMITER $$
DROP PROCEDURE IF EXISTS remove_character$$
CREATE PROCEDURE remove_character (IN current_character VARCHAR(100))
BEGIN 
	START TRANSACTION;
        DELETE FROM character_popularity WHERE current_character = character_popularity.character_name;
        DELETE FROM tier_placement WHERE current_character = tier_placement.character_name;
        DELETE FROM character_matchups WHERE current_character = character_matchups.character_name;
        DELETE FROM move_list WHERE current_character = move_list.character_name;
        DELETE FROM character_stats WHERE current_character = character_stats.character_name;
	COMMIT;
END;
$$


CALL remove_character("CAMMY");





