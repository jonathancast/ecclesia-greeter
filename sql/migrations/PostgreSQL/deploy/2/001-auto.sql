-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Thu May 17 02:59:47 2018
-- 
;
--
-- Table: members
--
CREATE TABLE "members" (
  "id" serial NOT NULL,
  "phone" text NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "members_phone" UNIQUE ("phone")
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
