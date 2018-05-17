-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Thu May 17 02:47:35 2018
-- 
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
