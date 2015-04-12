/*devicescard*/

select 	SUM(DEVICE_SUM_NO_NDS    * (`dc`.`PROC_ZAC` / 100)) 	as  T91,

	SUM(DEVICE_SUM_NO_NDS    * (`dc`.`PROC_PODR` / 100)) 	as  T92, 

	SUM(DEVICE_TRANSP_NO_NDS * (`dc`.`PROC_ZAC` / 100)) 	as  T93,    
 	
	SUM(DEVICE_TRANSP_NO_NDS * (`dc`.`PROC_PODR` / 100)) 	as  T94 

FROM `smetasourcedata` `ssd`

INNER JOIN `smetasourcedata` `ssd2` 	ON `ssd2`.`PARENT_ID` = `ssd`.`SM_ID`   	AND `ssd2`.`SM_TYPE` 	= 3 

INNER JOIN `data_estimate`   `de` 	ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID`  	AND `de`.`ID_TYPE_DATA` = 4

INNER JOIN `devicescard`     `dc` 	ON `dc`.`ID` = `de`.`ID_TABLES`

WHERE `ssd`.`SM_ID` = :SM_ID