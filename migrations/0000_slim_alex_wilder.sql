CREATE TABLE IF NOT EXISTS "activity_types" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT "activity_types_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "address" (
	"address_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"address1" varchar(50) NOT NULL,
	"address2" varchar(50),
	"district" varchar(50) NOT NULL,
	"city_id" serial NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "city" (
	"city_id" serial PRIMARY KEY NOT NULL,
	"city_name" varchar(50),
	"country_id" char
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "country" (
	"country_id" char(2) PRIMARY KEY NOT NULL,
	"country_name" varchar(50)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "device" (
	"device_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"device_name" varchar(20) NOT NULL,
	"device_type_id" "smallserial" NOT NULL,
	CONSTRAINT "device_device_name_unique" UNIQUE("device_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "device_reading" (
	"device_id" uuid NOT NULL,
	"time_of_reading" timestamp with time zone DEFAULT now(),
	"reading" integer NOT NULL,
	"time_used" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "device_types" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar NOT NULL,
	"wattage" integer NOT NULL,
	CONSTRAINT "device_types_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user" (
	"user_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"first_name" varchar(30) NOT NULL,
	"last_name" varchar(30) NOT NULL,
	"address_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_activity_score" (
	"user_id" uuid NOT NULL,
	"activity_type_id" "smallserial" NOT NULL,
	"score" smallint NOT NULL,
	"timestamp" timestamp with time zone DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "carbon_footprint" (
	"user_id" uuid NOT NULL,
	"carbon_footprint" integer NOT NULL,
	"timestamp" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_device" (
	"user_id" uuid NOT NULL,
	"device_id" uuid NOT NULL,
	CONSTRAINT "user_device_id" PRIMARY KEY("user_id","device_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_score" (
	"user_id" uuid NOT NULL,
	"score" smallint NOT NULL,
	"timestamp" timestamp DEFAULT now()
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address" ADD CONSTRAINT "address_city_id_city_city_id_fk" FOREIGN KEY ("city_id") REFERENCES "public"."city"("city_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "city" ADD CONSTRAINT "city_country_id_country_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."country"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "device" ADD CONSTRAINT "device_device_type_id_device_types_id_fk" FOREIGN KEY ("device_type_id") REFERENCES "public"."device_types"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "device_reading" ADD CONSTRAINT "device_reading_device_id_device_device_id_fk" FOREIGN KEY ("device_id") REFERENCES "public"."device"("device_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user" ADD CONSTRAINT "user_address_id_address_address_id_fk" FOREIGN KEY ("address_id") REFERENCES "public"."address"("address_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_activity_score" ADD CONSTRAINT "user_activity_score_user_id_user_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_activity_score" ADD CONSTRAINT "user_activity_score_activity_type_id_activity_types_id_fk" FOREIGN KEY ("activity_type_id") REFERENCES "public"."activity_types"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "carbon_footprint" ADD CONSTRAINT "carbon_footprint_user_id_user_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_device" ADD CONSTRAINT "user_device_user_id_user_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_device" ADD CONSTRAINT "user_device_device_id_device_device_id_fk" FOREIGN KEY ("device_id") REFERENCES "public"."device"("device_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_score" ADD CONSTRAINT "user_score_user_id_user_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
