BEGIN 
    FOR t IN (SELECT table_name 
              FROM   user_tables 
              WHERE  table_name LIKE 'PKB_ACTUAL_%' 
                      OR table_name = 'PKB_FC_DEMAND') LOOP 
        EXECUTE IMMEDIATE 'DELETE FROM '|| t.table_name || 
        ' WHERE product_name NOT IN (SELECT id FROM bembr1)'; 

        EXECUTE IMMEDIATE 'DELETE FROM '|| t.table_name || 
        ' WHERE organization_name NOT IN (SELECT id FROM bembr2)'; 
    END LOOP; 

    COMMIT; 
END;   