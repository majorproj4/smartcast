-- CreateEnum
CREATE TYPE "public"."webinarStatusEnum" AS ENUM ('SCHEDULED', 'LIVE', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "public"."ctaTypeEnum" AS ENUM ('BUY_NOW', 'BOOK_A_CALL');

-- CreateEnum
CREATE TYPE "public"."AttendanceTypeEnum" AS ENUM ('ATTENDED', 'ADDED_TO_CART', 'FOLLOW_UP', 'BREAKOUT_ROOM', 'COVERED', 'REGISTERED');

-- CreateEnum
CREATE TYPE "public"."CallStatusEnum" AS ENUM ('PENDING', 'COMPLETED', 'InProgress');

-- CreateTable
CREATE TABLE "public"."User" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(100) NOT NULL,
    "clerkId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "profileImage" TEXT NOT NULL,
    "stripeConnectId" VARCHAR(100),
    "LastLogin" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "Subscriptions" BOOLEAN NOT NULL DEFAULT false,
    "stripeCustomerId" VARCHAR(100),

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."webinar" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "title" VARCHAR(100) NOT NULL,
    "description" TEXT NOT NULL,
    "startTime" TIMESTAMP(3),
    "endTime" TIMESTAMP(3),
    "duration" INTEGER NOT NULL DEFAULT 0,
    "webinarStatus" "public"."webinarStatusEnum" NOT NULL DEFAULT 'SCHEDULED',
    "presenterId" UUID NOT NULL,
    "tags" TEXT[],
    "ctaLabel" VARCHAR(100),
    "ctaType" "public"."ctaTypeEnum" NOT NULL,
    "ctaUrl" VARCHAR(255),
    "couponCode" VARCHAR(100),
    "couponEnabled" BOOLEAN NOT NULL DEFAULT false,
    "couponExpiry" TIMESTAMP(3),
    "lockChat" BOOLEAN NOT NULL DEFAULT false,
    "stripeProductId" VARCHAR(100),
    "aiAgentId" UUID,
    "priceId" VARCHAR(100),
    "recordingUrl" TEXT,
    "thumbnailUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "attendeeId" UUID,

    CONSTRAINT "webinar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Attendee" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "email" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "callStatus" "public"."CallStatusEnum" NOT NULL DEFAULT 'PENDING',

    CONSTRAINT "Attendee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Attendance" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "webinarId" UUID NOT NULL,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "leftAt" TIMESTAMP(3),
    "attendeeId" UUID NOT NULL,
    "attendedType" "public"."AttendanceTypeEnum" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "Attendance_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_clerkId_key" ON "public"."User"("clerkId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "public"."User"("email");

-- CreateIndex
CREATE INDEX "User_clerkId_idx" ON "public"."User"("clerkId");

-- CreateIndex
CREATE INDEX "webinar_presenterId_idx" ON "public"."webinar"("presenterId");

-- CreateIndex
CREATE INDEX "webinar_aiAgentId_idx" ON "public"."webinar"("aiAgentId");

-- CreateIndex
CREATE INDEX "webinar_startTime_idx" ON "public"."webinar"("startTime");

-- CreateIndex
CREATE UNIQUE INDEX "Attendee_email_key" ON "public"."Attendee"("email");

-- CreateIndex
CREATE INDEX "Attendance_webinarId_idx" ON "public"."Attendance"("webinarId");

-- CreateIndex
CREATE INDEX "Attendance_attendedType_idx" ON "public"."Attendance"("attendedType");

-- CreateIndex
CREATE UNIQUE INDEX "Attendance_attendeeId_webinarId_key" ON "public"."Attendance"("attendeeId", "webinarId");

-- AddForeignKey
ALTER TABLE "public"."webinar" ADD CONSTRAINT "webinar_presenterId_fkey" FOREIGN KEY ("presenterId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."webinar" ADD CONSTRAINT "webinar_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES "public"."Attendee"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Attendance" ADD CONSTRAINT "Attendance_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES "public"."Attendee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Attendance" ADD CONSTRAINT "Attendance_webinarId_fkey" FOREIGN KEY ("webinarId") REFERENCES "public"."webinar"("id") ON DELETE CASCADE ON UPDATE CASCADE;
