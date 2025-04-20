/*
  # Create campaigns tables

  1. New Tables
    - `campaigns`
      - `id` (uuid, primary key)
      - `user_id` (uuid, references profiles)
      - `title` (text) - Job title/role
      - `location` (text) - Desired location
      - `industry` (text) - Target industry
      - `keywords` (text[]) - Search keywords
      - `resume_text` (text) - Resume content
      - `ai_instructions` (text) - Custom instructions for the AI
      - `is_active` (boolean) - Campaign status
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
      - `total_applications` (integer) - Count of applications sent
      - `success_rate` (float) - Success rate percentage
      - `reply_count` (integer) - Number of responses received

  2. Security
    - Enable RLS on `campaigns` table
    - Add policies for authenticated users to manage their own campaigns
*/

-- Create campaigns table
CREATE TABLE IF NOT EXISTS campaigns (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  title text NOT NULL,
  location text,
  industry text,
  keywords text[],
  resume_text text,
  ai_instructions text,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  total_applications integer DEFAULT 0,
  success_rate float DEFAULT 0,
  reply_count integer DEFAULT 0
);

-- Enable RLS
ALTER TABLE campaigns ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can create their own campaigns"
  ON campaigns
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own campaigns"
  ON campaigns
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own campaigns"
  ON campaigns
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own campaigns"
  ON campaigns
  FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Create updated_at trigger
CREATE TRIGGER update_campaigns_updated_at
  BEFORE UPDATE ON campaigns
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();