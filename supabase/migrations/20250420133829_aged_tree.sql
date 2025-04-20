/*
  # Add referral code system

  1. Changes
    - Add referral_code column to profiles table (6 digits, unique)
    - Add referred_by column to track who referred the user
    - Add function to generate unique referral codes
    - Add trigger to automatically generate referral code on insert

  2. Security
    - Maintain existing RLS policies
*/

-- Create sequence for referral codes
CREATE SEQUENCE IF NOT EXISTS referral_code_seq
  START WITH 100000
  INCREMENT BY 1
  MAXVALUE 999999
  CYCLE;

-- Function to generate a referral code using sequence
CREATE OR REPLACE FUNCTION generate_referral_code()
RETURNS text
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN LPAD(nextval('referral_code_seq')::text, 6, '0');
END;
$$;

-- Add referral columns
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS referral_code text UNIQUE,
ADD COLUMN IF NOT EXISTS referred_by text;

-- Set up foreign key after columns exist
ALTER TABLE profiles
ADD CONSTRAINT profiles_referred_by_fkey 
FOREIGN KEY (referred_by) 
REFERENCES profiles(referral_code)
ON DELETE SET NULL;

-- Create trigger function
CREATE OR REPLACE FUNCTION set_referral_code()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.referral_code IS NULL THEN
    NEW.referral_code := generate_referral_code();
  END IF;
  RETURN NEW;
END;
$$;

-- Create trigger
DROP TRIGGER IF EXISTS set_referral_code ON profiles;
CREATE TRIGGER set_referral_code
  BEFORE INSERT ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION set_referral_code();

-- Update existing profiles
UPDATE profiles
SET referral_code = generate_referral_code()
WHERE referral_code IS NULL;