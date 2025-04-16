BEGIN
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'ekbf');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'ext');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_actual');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_bulp');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_bupp');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_molp');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_mopp');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_stpp');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_tdlp');
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'plan_tdpp');
END;   