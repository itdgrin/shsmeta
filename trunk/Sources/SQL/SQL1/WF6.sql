
/*data_estimate*/

select 	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,ZP	,0)) 		as  T1,		 

	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,EMiM	,0))		as  T2,		 
	
	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,ZP_MASH	,0))		as  T3, 	 

	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,MR	,0))		as  T4,		 

	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,TRANSP	,0))		as  T5,	 

	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,ZIM_UDOR,0))		as T12, 

	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,ZP_ZIM_UDOR,0))		as T13,	 
	
	AVG(TRUD)						as T24,	 

	SUM(if(`de`.`ID_TYPE_DATA` = 1 ,TRUD_MASH,0))		as T23,	 

	SUM(if(`de`.`ID_TYPE_DATA` = 4 ,STOIM	,0))		as T6,	 

	SUM(if(`de`.`ID_TYPE_DATA` = 4 ,TRANSP	,0))		as T7,	 

	SUM(if(`de`.`ID_TYPE_DATA` = 5 ,STOIM	,0))		as T19,	 

	SUM(if(`de`.`ID_TYPE_DATA` = 2 ,STOIM	,0))		as T29,	 
	
	SUM(if(`de`.`ID_TYPE_DATA` = 7 or `de`.`ID_TYPE_DATA` = 9,STOIM	,0))	as T41	

FROM `smetasourcedata` `ssd`

INNER JOIN `smetasourcedata` `ssd2`	ON `ssd2`.`PARENT_ID` = `ssd`.`SM_ID`	AND `ssd2`.`SM_TYPE` 	= 3 

INNER JOIN `data_estimate` `de` 	ON  `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID` AND `de`.`ID_TYPE_DATA` = 1

WHERE `ssd`.`SM_ID` = :SM_ID