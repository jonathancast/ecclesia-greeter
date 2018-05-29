-- Convert schema 'sql/migrations/_source/deploy/5/001-auto.yml' to 'sql/migrations/_source/deploy/6/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "checkins" (
  "id" serial NOT NULL,
  "date" timestamptz NOT NULL,
  "member_id" integer NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "checkins_idx_member_id" on "checkins" ("member_id");

;
ALTER TABLE "checkins" ADD CONSTRAINT "checkins_fk_member_id" FOREIGN KEY ("member_id")
  REFERENCES "members" ("id") DEFERRABLE;

;

COMMIT;

