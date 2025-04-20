/*
  # Add onboarding steps tracking
  
  1. Changes
    - Add onboarding_step column to profiles table
    - Add onboarding data columns to profiles table
    
  2. Security
    - Update RLS policies to allow users to update their own profile
*/

-- Add onboarding columns to profiles table
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS onboarding_step integer DEFAULT 1;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS resume_text text;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS job_titles text[];
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS industry text;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS job_type text;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS work_location text;

-- Update RLS policies
CREATE POLICY "Users can update own profile during onboarding" ON profiles
  FOR UPDATE TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);