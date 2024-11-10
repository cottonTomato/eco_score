import {
  pgTable,
  uuid,
  varchar,
  char,
  smallserial,
  serial,
  smallint,
  integer,
  timestamp,
} from 'drizzle-orm/pg-core';

export const country = pgTable('country', {
  id: char('country_id', { length: 2 }).primaryKey(),
  name: varchar('country_name', { length: 50 }),
});

export const city = pgTable('city', {
  id: serial('city_id').primaryKey(),
  name: varchar('city_name', { length: 50 }),
  countryId: char('country_id').references(() => country.id),
});

export const address = pgTable('address', {
  id: uuid('address_id').primaryKey().defaultRandom(),
  line1: varchar('address1', { length: 50 }).notNull(),
  line2: varchar('address2', { length: 50 }),
  district: varchar('district', { length: 50 }).notNull(),
  cityId: serial('city_id')
    .notNull()
    .references(() => city.id),
});

export const user = pgTable('user', {
  id: uuid('user_id').primaryKey().defaultRandom(),
  firstName: varchar('first_name', { length: 30 }).notNull(),
  lastName: varchar('last_name', { length: 30 }).notNull(),
  addressId: uuid('address_id')
    .notNull()
    .references(() => address.id),
});

export const userScore = pgTable('user_score', {
  userId: uuid('user_id')
    .notNull()
    .references(() => user.id),
  score: smallint('score').notNull(),
  time: timestamp('timestamp').defaultNow(),
});

export const userCarbonFootprint = pgTable('carbon_footprint', {
  userId: uuid('user_id')
    .notNull()
    .references(() => user.id),
  score: integer('carbon_footprint').notNull(),
  time: timestamp('timestamp').defaultNow(),
});

export const deviceTypes = pgTable('device_types', {
  id: smallserial('id').primaryKey(),
  name: varchar('name').unique().notNull(),
});

export const device = pgTable('device', {
  id: uuid('device_id').primaryKey().defaultRandom(),
  name: varchar('device_name', { length: 20 }).unique().notNull(),
  type: smallserial('device_type_id')
    .notNull()
    .references(() => deviceTypes.id),
});

export const userDevice = pgTable('user_device', {
  userId: uuid('user_id')
    .notNull()
    .references(() => user.id),
  deviceId: uuid('device_id')
    .notNull()
    .references(() => device.id),
});

export const deviceReading = pgTable('device_reading', {
  deviceId: uuid('device_id')
    .notNull()
    .references(() => userDevice.deviceId),
  timeOfReading: timestamp('time_of_reading', {
    withTimezone: true,
  }).defaultNow(),
  reading: integer('reading').notNull(),
  timeUsed: timestamp('time_used', { withTimezone: true }),
});

export const activityTypes = pgTable('activity_types', {
  id: smallserial('id').primaryKey(),
  name: varchar('name').unique().notNull(),
});

export const userActivityScore = pgTable('user_activity_score', {
  userId: uuid('user_id')
    .notNull()
    .references(() => user.id),
  activityType: smallserial('activity_type_id')
    .notNull()
    .references(() => activityTypes.id),
  score: smallint('score').notNull(),
  time: timestamp('timestamp', { withTimezone: true }).defaultNow(),
});
