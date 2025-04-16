SELECT rownum                     AS inputsequence, 
       1                          AS actioncode, 
       ''                         AS current_id, 
       a.id, 
       ''                         AS parent_member_id, 
       ''                         AS member_tech_key, 
       ''                         AS messageid, 
       ''                         AS messagetext, 
       'en-US'                    AS culture_name, 
       c.name                     AS short_description, 
       c.descr                    AS long_description, 
       a.matching_key, 
       To_char(a.a5, 'DD-MON-YY') AS cal_startdate, 
       a.a16                      AS planningid 
FROM   bembr4 a, 
       level_definition b, 
       bembr4ml c 
WHERE  b.id = 'TOTYEAR' 
       AND a.level_def_tech_key = b.level_def_tech_key 
       AND a.member_tech_key = c.member_tech_key 
ORDER  BY a.id  