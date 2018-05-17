-- Convert schema 'sql/migrations/_source/deploy/1/001-auto.yml' to 'sql/migrations/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "members" (
  "id" serial NOT NULL,
  "phone" text NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "members_phone" UNIQUE ("phone")
);

;

COMMIT;

