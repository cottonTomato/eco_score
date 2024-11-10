ALTER TABLE "user" DROP CONSTRAINT "user_address_id_address_address_id_fk";
--> statement-breakpoint
ALTER TABLE "user" DROP COLUMN IF EXISTS "address_id";