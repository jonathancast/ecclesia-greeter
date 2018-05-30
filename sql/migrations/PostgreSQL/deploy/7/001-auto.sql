-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Wed May 30 08:52:28 2018
-- 
;
--
-- Table: families
--
CREATE TABLE "families" (
  "id" serial NOT NULL,
  PRIMARY KEY ("id")
);

;
--
-- Table: users
--
CREATE TABLE "users" (
  "id" serial NOT NULL,
  "login_id" text NOT NULL,
  "password" text NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "users_login_id" UNIQUE ("login_id")
);

;
--
-- Table: visitors
--
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
--
-- Table: members
--
CREATE TABLE "members" (
  "id" serial NOT NULL,
  "full_name" text NOT NULL,
  "family_id" integer NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "members_idx_family_id" on "members" ("family_id");

;
--
-- Table: checkins
--
CREATE TABLE "checkins" (
  "id" serial NOT NULL,
  "date" timestamptz NOT NULL,
  "member_id" integer NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "checkins_idx_member_id" on "checkins" ("member_id");

;
--
-- Table: phones
--
CREATE TABLE "phones" (
  "id" serial NOT NULL,
  "number" text NOT NULL,
  "member_id" integer NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "phones_number" UNIQUE ("number")
);
CREATE INDEX "phones_idx_member_id" on "phones" ("member_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "members" ADD CONSTRAINT "members_fk_family_id" FOREIGN KEY ("family_id")
  REFERENCES "families" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "checkins" ADD CONSTRAINT "checkins_fk_member_id" FOREIGN KEY ("member_id")
  REFERENCES "members" ("id") DEFERRABLE;

;
ALTER TABLE "phones" ADD CONSTRAINT "phones_fk_member_id" FOREIGN KEY ("member_id")
  REFERENCES "members" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
