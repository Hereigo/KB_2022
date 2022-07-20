--...
CREATE PROCEDURE pr_cursor_template1()
BEGIN
DECLARE aGOODSLIST_ID INT;
DECLARE aGOODS VARCHAR(100);
DECLARE aFACTORYPRICE DECIMAL(10,2);
DECLARE CUR_STOP INT DEFAULT FALSE; -- Reading Control Variable
DECLARE CUR CURSOR FOR #объявляем кур

SELECT G.GOODSLIST_ID, G.GOODS, G.FACTORYPRICE FROM goodslist G;
------------ NonExisted Row Reading Handler ----------------
DECLARE CONTINUE HANDLER FOR NOT FOUND SET CUR_STOP = TRUE;
--------------------------------------------------------------------
OPEN CUR;
----------------- Unlimited Reading Loop ---------------
cur_loop: LOOP
FETCH CUR INTO aGOODSLIST_ID, aGOODS, aFACTORYPRICE;
IF CUR_STOP THEN
LEAVE cur_loop; #выход из цикла
END IF;
----------------- Data Processing ---------------------------
IF (aFACTORYPRICE>10000) THEN
BEGIN
-- ...
SELECT aGOODSLIST_ID, aGOODS, aFACTORYPRICE;
END;
END IF;
END LOOP;

CLOSE CUR;