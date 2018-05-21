-- Convert schema 'sql/migrations/_source/deploy/5/001-auto.yml' to 'sql/migrations/_source/deploy/4/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE members DROP CONSTRAINT members_fk_family_id;

;
DROP INDEX members_idx_family_id;

;
ALTER TABLE members DROP COLUMN family_id;

;
DROP TABLE families CASCADE;

;

COMMIT;

