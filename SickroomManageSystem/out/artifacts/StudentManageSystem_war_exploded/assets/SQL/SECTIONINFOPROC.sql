CREATE OR REPLACE 
PROCEDURE SectionInformation(sname in ROOM."section"%TYPE,residual out NVARCHAR2)
AS
roomID NVARCHAR2(20);
dir NVARCHAR2(20);
bedNUM NUMBER;
CURSOR MYCUR3 IS
SELECT SUBSTR(SICK."room",0,3),SECTION."dir",GETBEDNUMBER(SUBSTR(SICK."room",0,3))
FROM SECTION,SICK
WHERE SECTION."name"=sname AND SICK."section"=sname;
BEGIN
	OPEN MYCUR3;
	FETCH MYCUR3 INTO roomID,dir,bedNUM;
	LOOP
		SELECT CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(roomID,'-'),dir),'-'),bedNUM),'|'),residual) INTO residual FROM dual;
		FETCH MYCUR3 INTO roomID,dir,bedNUM;
		EXIT WHEN MYCUR3%NOTFOUND;
	END LOOP;
	CLOSE MYCUR3;
END;
