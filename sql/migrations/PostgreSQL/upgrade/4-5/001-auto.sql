-- Convert schema 'sql/migrations/_source/deploy/4/001-auto.yml' to 'sql/migrations/_source/deploy/5/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "families" (
  "id" serial NOT NULL,
  PRIMARY KEY ("id")
);

;
ALTER TABLE members ADD COLUMN family_id integer NULL;

;
CREATE INDEX members_idx_family_id on members (family_id);

;
ALTER TABLE members ADD CONSTRAINT members_fk_family_id FOREIGN KEY (family_id)
  REFERENCES families (id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

