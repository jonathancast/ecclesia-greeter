-- Convert schema 'sql/migrations/_source/deploy/8/001-auto.yml' to 'sql/migrations/_source/deploy/7/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE checkins ALTER COLUMN date TYPE timestamptz;

;
ALTER TABLE visitors ALTER COLUMN date TYPE timestamptz;

;

COMMIT;

