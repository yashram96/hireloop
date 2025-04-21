/*
  # Add campaign preferences fields

  1. Changes
    - Add experience and role type fields
    - Add company preferences fields
    - Add timing and availability fields
    - Add compensation fields
    - Add visa and work authorization fields
    - Add job posting preferences fields

  2. Security
    - Maintain existing RLS policies
*/

-- Add experience and role type fields
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS years_of_experience integer;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS employment_type text;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS job_level text;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS remote_preference text;

-- Add company preferences
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS company_size text;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS preferred_companies text[];
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS blocked_companies text[];

-- Add timing and availability
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS joining_availability text;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS preferred_shift text;

-- Add compensation preferences
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS salary_min integer;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS salary_max integer;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS salary_currency text;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS compensation_type text;

-- Add visa and work authorization
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS requires_visa boolean;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS work_authorization_status text;

-- Add job posting preferences
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS posting_recency text;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS preferred_job_boards text[];
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS application_type text;
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS preferred_tech_stack text[];
ALTER TABLE campaigns ADD COLUMN IF NOT EXISTS language_requirements text[];