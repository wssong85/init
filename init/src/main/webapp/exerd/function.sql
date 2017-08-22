## 마리아 다음 순번
## select SEQ_NAME_NEXTVAL('TB_BOARD_MANAGE') from dual
delimiter ;;

CREATE FUNCTION SEQ_NAME_CURRVAL(str VARCHAR(100))
RETURNS int
LANGUAGE SQL
NOT DETERMINISTIC
MODIFIES SQL DATA
SQL SECURITY INVOKER
MainBlock: BEGIN

    DECLARE cur_val int;

    SELECT
        TB_SEQ INTO cur_val
    FROM
        TB_COM_SEQ        
    WHERE TB_NM = str    
    ;

    RETURN cur_val;

END MainBlock;;

delimiter ;;

## marid 현재 순번
## select SEQ_NAME_CURRVAL('TB_BOARD_MANAGE') from dual
DELIMITER ;;

CREATE FUNCTION SEQ_NAME_NEXTVAL(str VARCHAR(100))
 RETURNS bigint
 LANGUAGE SQL
 NOT DETERMINISTIC
 MODIFIES SQL DATA
 SQL SECURITY INVOKER
 COMMENT ''
MainBlock: BEGIN

UPDATE TB_COM_SEQ
SET TB_SEQ = (@v_current_value:= (TB_SEQ+1 ))
,LAST_UPDATE_DATE = now()
,TB_NM = str
where TB_NM = str;

RETURN @v_current_value;

END MainBlock
;;

