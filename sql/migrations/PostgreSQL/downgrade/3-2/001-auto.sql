-- Convert schema 'sql/migrations/_source/deploy/3/001-auto.yml' to 'sql/migrations/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE members ADD COLUMN phone text NULL;

update members set phone = (select number from phones x where x.member_id = members.id);

alter table members alter column phone set not null;

;
ALTER TABLE members ADD CONSTRAINT members_phone UNIQUE (phone);

;
DROP TABLE phones CASCADE;

;

COMMIT;

