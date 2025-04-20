/*
  # Add referral code to profiles

  1. Changes
    - Add referral_code column to profiles table (6 digits, unique)
    - Add referred_by column to track who referred the user
    - Add function to generate unique 6-digit referral codes
    - Add trigger to automatically generate referral code on insert

  2. Security
    - Maintain existing RLS policies
*/

-- Function to generate a random 6-digit number
CREATE OR REPLACE FUNCTION generate_referral_code()
RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
  new_code TEXT;
  code_exists BOOLEAN;
BEGIN
  LOOP
    -- Generate a random 6-digit number
    new_code := LPAD(FLOOR(RANDOM() * 1000000)::TEXT, 6, '0');
    
    -- Check if code already exists
    SELECT EXISTS (
      SELECT 1 FROM profiles WHERE referral_code = new_code
    ) INTO code_exists;
    
    -- Exit loop if unique code found
    EXIT WHEN NOT code_exists;
  END LOOP;
  
  RETURN new_code;
END;
$$;

-- Add referral columns
ALTER TABLE profiles
ADD COLUMN referral_code TEXT UNIQUE DEFAULT generate_referral_code(),
ADD COLUMN referred_by TEXT REFERENCES profiles(referral_code);

-- Create trigger to generate referral code on insert
CREATE TRIGGER set_referral_code
  BEFORE INSERT ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION generate_referral_code();

-- Update existing profiles with referral codes
DO $$
BEGIN
  UPDATE profiles
  SET referral_code = generate_referral_code()
  WHERE referral_code IS NULL;
END $$;