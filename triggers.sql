-- -----------
-- triggers --
-- -----------

CREATE TABLE trigger_test (
    message VARCHAR(100)
);
-- this has to be executed inside mysql shell
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('Added new employee.');
    END$$
DELIMITER ;

INSERT INTO employee VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 2);

-- another trigger example (triggers have to ahve unique names)
DELIMITER $$
CREATE
    TRIGGER my_trigger_name BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
    END$$
DELIMITER ;

INSERT INTO employee VALUES(110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 2);

-- yet another trigger example (this time with an 'if' statement)
DELIMITER $$
CREATE
    TRIGGER my_trigger_sex BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        IF NEW.sex = 'M' THEN
            INSERT INTO trigger_test VALUES('Added male employee.');
        ELSEIF NEW.sex = 'F' THEN
            INSERT INTO trigger_test VALUES('Added female employee.');
        ELSE
            INSERT INTO trigger_test VALUES('Added other employee.');
        END IF; 
    END$$
DELIMITER ;

INSERT INTO employee VALUES(111, 'Pam', 'Beesly', '1988-04-12', 'F', 50000, 106, 2)

-- TRIGGER also works with UPDATE AND DELETE
-- TRIGGER can be DROPped
-- TRIGGER can be set AFTER
