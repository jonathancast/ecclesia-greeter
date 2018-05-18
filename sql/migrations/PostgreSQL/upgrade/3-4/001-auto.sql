-- Convert schema 'sql/migrations/_source/deploy/3/001-auto.yml' to 'sql/migrations/_source/deploy/4/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE members ADD COLUMN full_name text NULL;

;

COMMIT;

