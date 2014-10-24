«»

+      +      +      +         +            +                      + 
ID, OBJ_ID, SM_ID, BD_ID, NORMATIV_ID, MATERIAL_ID, MAT_ACTIVE, MAT_CODE, MAT_NAME, MAT_NORMA, UNIT_ID, COUNT, COAST_NO_NDS, NDS, COAST_NDS, PRICE, COEF_TR_ZATR, STATE_MATERIAL, STATE_TRANSPORT, DOC_DATE, DOC_NUM

SELECT norm_num FROM (SELECT material_id FROM material WHERE mat_code LIKE "Ï%") TMat, materialnorm, normativg, materialcoastg
WHERE TMat.material_id = materialnorm.material_id and TMat.material_id = materialcoastg.material_id and 
materialnorm.normativ_id = normativg.normativ_id

Call DeleteAllDataEstimate;

SELECT distinct material.material_id, mat_code FROM material, materialnorm, materialcoastg
WHERE material.material_id = materialnorm.material_id and material.material_id = materialcoastg.material_id and normativ_id = 5640

SELECT coast1_1, coast1_2 FROM materialcoastg WHERE material_id = 1488 and monat = 5 and year = 2012

CALL AddMaterialsFromRates(220, 5640);


