-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Fri May 18 23:00:53 2018
-- 
;
--
-- Table: members
--
CREATE TABLE "members" (
  "id" serial NOT NULL,
  "full_name" text NOT NULL,
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
ALTER TABLE "phones" ADD CONSTRAINT "phones_fk_member_id" FOREIGN KEY ("member_id")
  REFERENCES "members" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
