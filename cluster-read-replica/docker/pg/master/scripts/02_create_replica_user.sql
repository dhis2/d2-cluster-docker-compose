CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'my_replicator_password';
SELECT * FROM pg_create_physical_replication_slot('replication_slot_rr1');