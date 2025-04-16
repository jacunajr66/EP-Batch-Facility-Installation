SELECT rownum                     AS inputsequence, 
       1                          AS actioncode, 
       ''                         AS current_id, 
       a.id, 
       c.id                       AS parent_member_id, 
       ''                         AS member_tech_key, 
       ''                         AS messageid, 
       ''                         AS messagetext, 
       'en-US'                    AS culture_name, 
       e.name                     AS short_description, 
       e.descr                    AS long_description, 
       a.matching_key, 
       To_char(a.a5, 'DD-MON-YY') AS cal_startdate, 
       a.a16                      AS planningid 
FROM   bembr4 a, 
       level_definition b, 
       bembr4 c, 
       bembrrel4 d, 
       bembr4ml e 
WHERE  b.id = 'QUARTER' 
       AND a.level_def_tech_key = b.level_def_tech_key 
       AND a.member_tech_key = e.member_tech_key 
       AND ( c.member_tech_key = d.ancestor_member_tech_key 
             AND c.level_def_tech_key = d.ancestor_level_def_tech_key ) 
       AND ( d.descendent_member_tech_key = a.member_tech_key 
             AND d.descendent_level_def_tech_key = a.level_def_tech_key 
             AND d.ancestor_distance_from_core = d.descendent_distance_from_core + 1 ) 
ORDER  BY a.id  