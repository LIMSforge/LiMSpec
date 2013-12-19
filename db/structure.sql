CREATE TABLE "app_settings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "showIndustry" boolean, "showSelected" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "authentications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "provider" varchar(255), "uid" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "user_id" integer);
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "catName" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "catAbbr" varchar(255));
CREATE TABLE "ind_questions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "industry_id" integer, "question_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "ind_requirements" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "industry_id" integer, "requirement_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "ind_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "industry_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "industries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "indName" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "oauth_access_grants" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "resource_owner_id" integer NOT NULL, "application_id" integer NOT NULL, "token" varchar(255) NOT NULL, "expires_in" integer NOT NULL, "redirect_uri" varchar(255) NOT NULL, "created_at" datetime NOT NULL, "revoked_at" datetime, "scopes" varchar(255));
CREATE TABLE "oauth_access_tokens" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "resource_owner_id" integer, "application_id" integer NOT NULL, "token" varchar(255) NOT NULL, "refresh_token" varchar(255), "expires_in" integer, "revoked_at" datetime, "created_at" datetime NOT NULL, "scopes" varchar(255));
CREATE TABLE "oauth_applications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "uid" varchar(255) NOT NULL, "secret" varchar(255) NOT NULL, "redirect_uri" varchar(255) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "questions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "qTitle" varchar(255), "qText" text, "status" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "source_id" integer);
CREATE TABLE "requirements" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "reqTitle" varchar(255), "reqText" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "category_id" integer, "status" varchar(255), "source_id" integer);
CREATE TABLE "role_assignments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "role_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "roleName" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "user_questions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "question_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "relationship" varchar(255));
CREATE TABLE "user_requirement_orders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "requirement_id" integer, "requirementOrder" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "user_requirements" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "requirement_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "relationship" varchar(255));
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "provider" varchar(255), "uid" integer, "email" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password_reset_token" varchar(255), "password_reset_sent_at" datetime, "firstname" varchar(255), "lastname" varchar(255), "company" varchar(255), "workPhone" varchar(255), "emailSystemNotify" boolean DEFAULT 't', "emailGeneral" boolean, "password_digest" varchar(255));
CREATE TABLE "vendor_requests" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_oauth_access_grants_on_token" ON "oauth_access_grants" ("token");
CREATE UNIQUE INDEX "index_oauth_access_tokens_on_refresh_token" ON "oauth_access_tokens" ("refresh_token");
CREATE INDEX "index_oauth_access_tokens_on_resource_owner_id" ON "oauth_access_tokens" ("resource_owner_id");
CREATE UNIQUE INDEX "index_oauth_access_tokens_on_token" ON "oauth_access_tokens" ("token");
CREATE UNIQUE INDEX "index_oauth_applications_on_uid" ON "oauth_applications" ("uid");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120601061827');

INSERT INTO schema_migrations (version) VALUES ('20120601061854');

INSERT INTO schema_migrations (version) VALUES ('20120601061920');

INSERT INTO schema_migrations (version) VALUES ('20120601061941');

INSERT INTO schema_migrations (version) VALUES ('20120602141506');

INSERT INTO schema_migrations (version) VALUES ('20120602143204');

INSERT INTO schema_migrations (version) VALUES ('20120602185508');

INSERT INTO schema_migrations (version) VALUES ('20120602185831');

INSERT INTO schema_migrations (version) VALUES ('20120603054551');

INSERT INTO schema_migrations (version) VALUES ('20120605042529');

INSERT INTO schema_migrations (version) VALUES ('20120608023251');

INSERT INTO schema_migrations (version) VALUES ('20120608025846');

INSERT INTO schema_migrations (version) VALUES ('20120612043119');

INSERT INTO schema_migrations (version) VALUES ('20120613022116');

INSERT INTO schema_migrations (version) VALUES ('20120613043452');

INSERT INTO schema_migrations (version) VALUES ('20120616041258');

INSERT INTO schema_migrations (version) VALUES ('20120617031918');

INSERT INTO schema_migrations (version) VALUES ('20120619053957');

INSERT INTO schema_migrations (version) VALUES ('20120620040545');

INSERT INTO schema_migrations (version) VALUES ('20120620040932');

INSERT INTO schema_migrations (version) VALUES ('20120626023717');

INSERT INTO schema_migrations (version) VALUES ('20120626023943');

INSERT INTO schema_migrations (version) VALUES ('20120628021622');

INSERT INTO schema_migrations (version) VALUES ('20120628031738');

INSERT INTO schema_migrations (version) VALUES ('20120628043336');

INSERT INTO schema_migrations (version) VALUES ('20120712053159');

INSERT INTO schema_migrations (version) VALUES ('20120718053508');

INSERT INTO schema_migrations (version) VALUES ('20120718055241');

INSERT INTO schema_migrations (version) VALUES ('20120719023932');

INSERT INTO schema_migrations (version) VALUES ('20120719024016');

INSERT INTO schema_migrations (version) VALUES ('20120727054934');

INSERT INTO schema_migrations (version) VALUES ('20120731051616');

INSERT INTO schema_migrations (version) VALUES ('20120816021007');

INSERT INTO schema_migrations (version) VALUES ('20120905004407');

INSERT INTO schema_migrations (version) VALUES ('20120928051626');

INSERT INTO schema_migrations (version) VALUES ('20121025031005');

INSERT INTO schema_migrations (version) VALUES ('20121215064518');

INSERT INTO schema_migrations (version) VALUES ('20121218145526');

INSERT INTO schema_migrations (version) VALUES ('20121222045557');

INSERT INTO schema_migrations (version) VALUES ('20121224222931');

INSERT INTO schema_migrations (version) VALUES ('20121224225304');

INSERT INTO schema_migrations (version) VALUES ('20130119011620');

INSERT INTO schema_migrations (version) VALUES ('20130119014125');

INSERT INTO schema_migrations (version) VALUES ('20130122032657');