/*
  # Update referral code system to use alphanumeric codes

  1. Changes
    - Replace numeric referral codes with alphanumeric codes
    - Update generation function to create random 6-character codes
    - Maintain existing relationships and constraints

  2. Security
    - Maintain existing RLS policies
*/

-- Function to generate a random alphanumeric code
CREATE OR REPLACE FUNCTION generate_referral_code()
RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
  chars text[] := ARRAY['0','1','2','3','4','5','6','7','8','9',
                       'A','B','C','D','E','F','G','H','I','J',
                       'K','L','M','N','O','P','Q','R','S','T',
                       'U','V','W','X','Y','Z'];
  result text := '';
  i integer := 0;
  new_code text;
  code_exists boolean;
BEGIN
  LOOP
    -- Generate a random 6-character code
    result := '';
    FOR i IN 1..6 LOOP
      result := result || chars[1 + floor(random() * array_length(chars, 1))];
    END LOOP;
    
    -- Check if code already exists
    SELECT EXISTS (
      SELECT 1 FROM profiles WHERE referral_code = result
    ) INTO code_exists;
    
    -- Exit loop if unique code found
    EXIT WHEN NOT code_exists;
  END LOOP;
  
  RETURN result;
END;
$$;

-- Drop existing sequence as we no longer need it
DROP SEQUENCE IF EXISTS referral_code_seq;

-- Add referral columns if they don't exist
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS referral_code text UNIQUE,
ADD COLUMN IF NOT EXISTS referred_by text;

-- Set up foreign key
ALTER TABLE profiles
DROP CONSTRAINT IF EXISTS profiles_referred_by_fkey;

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

-- Update existing profiles with new alphanumeric codes
UPDATE profiles
SET referral_code = generate_referral_code()
WHERE referral_code IS NULL;