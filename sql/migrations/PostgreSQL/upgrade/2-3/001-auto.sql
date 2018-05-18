-- Convert schema 'sql/migrations/_source/deploy/2/001-auto.yml' to 'sql/migrations/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "phones" (
  "id" serial NOT NULL,
  "number" text NOT NULL,
  "member_id" integer NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "phones_number" UNIQUE ("number")
);
CREATE INDEX "phones_idx_member_id" on "phones" ("member_id");

;
ALTER TABLE "phones" ADD CONSTRAINT "phones_fk_member_id" FOREIGN KEY ("member_id")
  REFERENCES "members" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE members DROP CONSTRAINT members_phone;

;

insert into phones (member_id, number) select id, phone from members;

ALTER TABLE members DROP COLUMN phone;

;

COMMIT;

