/*data_act*/

select 	SUM(EMiM)	as  T203,  
	
	SUM(ZP_MASH) 	as  T204  

FROM `smetasourcedata` `ssd`

INNER JOIN `smetasourcedata` `ssd2` 	ON `ssd2`.`PARENT_ID` = `ssd`.`SM_ID`	AND `ssd2`.`SM_TYPE` 	= 3 

INNER JOIN `data_act` 	     `de` 	ON  `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID` AND `de`.`ID_TYPE_DATA` = 1

WHERE `ssd`.`SM_ID` = :SM_ID