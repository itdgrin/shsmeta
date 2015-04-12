/* materialcard */


select 	round(sum(rezult.MAT_PROC_PODR)) 	as T81, 	 
	
	round(sum(rezult.MAT_PROC_ZAC)) 	as T82, 	 

	round(sum(rezult.TRANSP_PROC_PODR)) 	as T83, 	 

	round(sum(rezult.TRANSP_PROC_ZAC)) 	as T84 	 

from (

	select 	MAT_SUM_NO_NDS * (`mtc`.`MAT_PROC_PODR` / 100)   	as MAT_PROC_PODR,

		MAT_SUM_NO_NDS * ( `mtc`.`MAT_PROC_ZAC` / 100)   	as MAT_PROC_ZAC,

		TRANSP_NO_NDS  * (`mtc`.`TRANSP_PROC_PODR` / 100) 	as TRANSP_PROC_PODR,

		TRANSP_NO_NDS  * (`mtc`.`TRANSP_PROC_ZAC` / 100) 	as TRANSP_PROC_ZAC

	FROM `smetasourcedata` `ssd`

	INNER JOIN `smetasourcedata` `ssd1` 	ON `ssd1`.`PARENT_ID` = `ssd`.`SM_ID` 	AND `ssd1`.`SM_TYPE` 	= 1

	INNER JOIN `smetasourcedata` `ssd2`	ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID`	AND `ssd2`.`SM_TYPE` 	= 3 

	INNER JOIN `data_estimate` `de` 	ON  `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID` AND `de`.`ID_TYPE_DATA` = 1

	INNER JOIN `card_rate` `cr` 		ON `cr`.`ID` = `de`.`ID_TABLES`

	INNER JOIN `materialcard` `mtc` ON `mtc`.`ID_CARD_RATE` = `cr`.`ID`

	WHERE `ssd`.`SM_ID` = :SM_ID

union

	select 	MAT_SUM_NO_NDS * (`mtc`.`MAT_PROC_PODR` / 100) 		as MAT_PROC_PODR, 
		
		MAT_SUM_NO_NDS * ( `mtc`.`MAT_PROC_ZAC` / 100)  	as MAT_PROC_ZAC,

		TRANSP_NO_NDS  * (`mtc`.`TRANSP_PROC_PODR` / 100) 	as TRANSP_PROC_PODR,
 
		TRANSP_NO_NDS  * (`mtc`.`TRANSP_PROC_ZAC` / 100) 	as MAT_PROC_ZAC

	FROM `smetasourcedata` `ssd`

	INNER JOIN `smetasourcedata` `ssd1` 	ON `ssd1`.`PARENT_ID` = `ssd`.`SM_ID` 	AND `ssd1`.`SM_TYPE` 	= 1

	INNER JOIN `smetasourcedata` `ssd2`	ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID`	AND `ssd2`.`SM_TYPE` 	= 3  

	INNER JOIN `data_estimate` `de` 	ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID` 	AND `de`.`ID_TYPE_DATA` = 2

	INNER JOIN `materialcard` `mtc` 	ON `mtc`.`ID` = `de`.`ID_TABLES` 	AND `mtc`.`ID_CARD_RATE` = 0

WHERE `ssd`.`SM_ID` = :SM_ID) as rezult