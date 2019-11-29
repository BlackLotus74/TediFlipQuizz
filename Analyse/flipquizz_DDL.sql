-- DROP DATABASE IF EXISTS flipquizz;

-- CREATE DATABASE IF NOT EXISTS flipquizz;

USE flipquizz;


DROP TABLE IF EXISTS TURNS;
DROP TABLE IF EXISTS GAMES_TEAMS;
DROP TABLE IF EXISTS QUIZZ_THEMES;
DROP TABLE IF EXISTS QUESTIONS;
DROP TABLE IF EXISTS GAMES;
DROP TABLE IF EXISTS LEVELS;
DROP TABLE IF EXISTS THEMES;
DROP TABLE IF EXISTS QUIZZ;
DROP TABLE IF EXISTS TEAMS;



CREATE TABLE IF NOT EXISTS TEAMS(
   team_id INT PRIMARY KEY AUTO_INCREMENT,
   team_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS QUIZZ(
   quizz_id INT PRIMARY KEY AUTO_INCREMENT,
   quizz_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS THEMES(
   theme_id INT PRIMARY KEY AUTO_INCREMENT,
   theme_name VARCHAR(50) NOT NULL,
   theme_description TEXT
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS LEVELS(
   level_id INT PRIMARY KEY AUTO_INCREMENT,
   level_point INT NOT NULL
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS GAMES(
   game_id INT PRIMARY KEY AUTO_INCREMENT,
   game_date DATETIME NOT NULL,
   quizz_id INT NOT NULL
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS QUESTIONS(
   question_id INT PRIMARY KEY AUTO_INCREMENT,
   question_content VARCHAR(255) NOT NULL,
   question_answer VARCHAR(255) NOT NULL,
   level_id INT NOT NULL,
   theme_id INT NOT NULL
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS QUIZZ_THEMES(
   theme_id INT NOT NULL,
   quizz_id INT NOT NULL,
   PRIMARY KEY(theme_id, quizz_id)
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS GAMES_TEAMS(
   game_id INT NOT NULL,
   team_id INT NOT NULL,
   PRIMARY KEY(game_id, team_id)
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS TURNS(
   team_id INT NOT NULL,
   question_id INT NOT NULL,
   game_id INT NOT NULL,
   PRIMARY KEY(team_id, question_id, game_id),
   turn_points INT NOT NULL
) ENGINE=InnoDB CHARACTER SET UTF8 COLLATE utf8_general_ci;


ALTER TABLE `GAMES` ADD INDEX(`quizz_id`);
ALTER TABLE `QUESTIONS` ADD INDEX(`level_id`);
ALTER TABLE `QUESTIONS` ADD INDEX(`theme_id`);
ALTER TABLE `QUIZZ_THEMES` ADD INDEX(`quizz_id`);
ALTER TABLE `QUIZZ_THEMES` ADD INDEX(`theme_id`);
ALTER TABLE `GAMES_TEAMS` ADD INDEX(`game_id`);
ALTER TABLE `GAMES_TEAMS` ADD INDEX(`team_id`);
ALTER TABLE `TURNS` ADD INDEX(`team_id`);
ALTER TABLE `TURNS` ADD INDEX(`game_id`);
ALTER TABLE `TURNS` ADD INDEX(`question_id`);


ALTER TABLE GAMES ADD FOREIGN KEY (quizz_id) REFERENCES QUIZZ(quizz_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE QUESTIONS ADD FOREIGN KEY (level_id) REFERENCES LEVELS(level_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE QUESTIONS ADD FOREIGN KEY (theme_id) REFERENCES THEMES(theme_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE QUIZZ_THEMES ADD FOREIGN KEY (quizz_id) REFERENCES QUIZZ(quizz_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE QUIZZ_THEMES ADD FOREIGN KEY (theme_id) REFERENCES THEMES(theme_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE GAMES_TEAMS ADD FOREIGN KEY (game_id) REFERENCES GAMES(game_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE GAMES_TEAMS ADD FOREIGN KEY (team_id) REFERENCES TEAMS(team_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE TURNS ADD FOREIGN KEY (team_id) REFERENCES TEAMS(team_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE TURNS ADD FOREIGN KEY (game_id) REFERENCES GAMES(game_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE TURNS ADD FOREIGN KEY (question_id) REFERENCES QUESTIONS(question_id) ON UPDATE RESTRICT ON DELETE RESTRICT;