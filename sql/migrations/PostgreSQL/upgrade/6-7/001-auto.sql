-- Convert schema 'sql/migrations/_source/deploy/6/001-auto.yml' to 'sql/migrations/_source/deploy/7/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "visitors" (
  "id" serial NOT NULL,
  "date" timestamptz NOT NULL,
  "name" text NOT NULL,
  "phone" text,
  "email" text,
  "address" text,
  "address2" text,
  "city" text,
  "state" text,
  "number" integer NOT NULL,
  "num_children" integer NOT NULL,
  PRIMARY KEY ("id")
);

;

COMMIT;

